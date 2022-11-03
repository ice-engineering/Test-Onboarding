param(
    [Parameter(Mandatory=$true)][string]$ResourceGroup,
    [Parameter(Mandatory=$true)][string]$Workspace,
    [Parameter(Mandatory=$true)][string[]]$customWorkbooks
)

$context = Get-AzContext

if(!$context){
    Connect-AzAccount
    $context = Get-AzContext
}

$SubscriptionId = $context.Subscription.Id

Write-Host "Connected to Azure with subscription: " + $context.Subscription

$baseUri = "/subscriptions/${SubscriptionId}/resourceGroups/${ResourceGroup}/providers/Microsoft.OperationalInsights/workspaces/${Workspace}"
$workbookUri = "$baseUri/providers/Microsoft.Insights/workbooks/"

$customWorkbooks = @("iCEReporting")

if ($customWorkbooks){
    foreach ($workbook in $customWorkbooks){

        $workbookName = $workbook.replace(' ','')

        $serializedData = (Invoke-webrequest -URI "https://raw.githubusercontent.com/ice-engineering/Test-Onboarding/AlexTest/WorkbookTesting/" + $workbookName + ".json").Content

        $guid = New-Guid

        $properties = @{
            displayName = $workbook
            serializedData = $serializedData
            version = "1.0"
            sourceId = $Workspace
            category = "sentinel"
        }

        $workbookUriGuid = $workbookUri + $guid + '?api-version=2020-01-01'

        $workbookBody = @{}
        $workbookBody | Add-Member -NotePropertyName name -NotePropertyValue $guid
        $workbookBody | Add-Member -NotePropertyName type -NotePropertyValue "microsoft.insights/workbooks"
        $workbookBody | Add-Member -NotePropertyName location -NotePropertyValue $ResourceGroup.location
        $workbookBody | Add-Member -NotePropertyName apiVersion -NotePropertyValue "2021-08-01"
        $workbookBody | Add-Member -NotePropertyName kind -NotePropertyValue "shared"
        $workbookBody | Add-Member -NotePropertyName properties -NotePropertyValue $properties

        try{
            Invoke-AzRestMethod -Path $workbookUriGuid -Method PUT -Payload ($workbookBody | ConvertTo-Json -Depth 3)
        }
        catch {
            Write-Verbose $_
            Write-Error "Unable to create workbook with error code: $($_.Exception.Message)" -ErrorAction Stop
        }
    }
}
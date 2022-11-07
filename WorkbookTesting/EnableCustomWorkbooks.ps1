param(
    [Parameter(Mandatory=$true)][string]$ResourceGroup,
    [Parameter(Mandatory=$true)][string]$Workspace
    #[Parameter(Mandatory=$true)][string[]]$customWorkbooks
)

$context = Get-AzContext

if(!$context){
    Connect-AzAccount
    $context = Get-AzContext
}

$SubscriptionId = $context.Subscription.Id

Write-Host "Connected to Azure with subscription: " + $context.Subscription

$workbookUri = "/subscriptions/${SubscriptionId}/resourceGroups/${ResourceGroup}/providers/Microsoft.Insights/workbooks/"

$customWorkbooks = @("iCEReporting")

Write-Host "Break 0"

if ($customWorkbooks){
    foreach ($workbook in $customWorkbooks){

        $workbookName = $workbook.replace(' ','')

        Write-Host "Break 1"

        $serializedData = (Invoke-webrequest -URI "https://raw.githubusercontent.com/ice-engineering/Test-Onboarding/AlexTest/WorkbookTesting/iCEReporting.json").Content

        $guid = New-Guid

        $properties = @{
            displayName = $workbook
            serializedData = $serializedData
            version = "1.0"
            sourceId = $Workspace
            category = "sentinel"
        }

        Write-Host "Break 2"

        $workbookUriGuid = $workbookUri + $guid + '?api-version=2021-08-01'

        Write-Host $workbookUriGuid

        Write-Host $ResourceGroup.location

        $workbookBody = @{}
        $workbookBody | Add-Member -NotePropertyName name -NotePropertyValue $guid
        $workbookBody | Add-Member -NotePropertyName type -NotePropertyValue "microsoft.insights/workbooks"
        $workbookBody | Add-Member -NotePropertyName location -NotePropertyValue $ResourceGroup.location
        $workbookBody | Add-Member -NotePropertyName kind -NotePropertyValue "shared"
        $workbookBody | Add-Member -NotePropertyName properties -NotePropertyValue $properties

        Write-Host "Break 3"

        try{
            Invoke-AzRestMethod -Path $workbookUriGuid -Method PUT -Payload ($workbookBody | ConvertTo-Json -Depth 3)
        }
        catch {
            Write-Verbose $_
            Write-Error "Unable to create workbook with error code: $($_.Exception.Message)" -ErrorAction Stop
        }

        Write-Host "Break 4"
    }
}
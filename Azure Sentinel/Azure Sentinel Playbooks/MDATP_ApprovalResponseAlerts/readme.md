Description: Azure Sentinel playbook to send approval request to the SOC team to approve the following actions:

1. AV scan,

2. Collect investigate package,

3. Disable Azure AD sign-in.

Permissions required:

• Azure Sentinel playbook: Azure Sentinel Contributor

• Managed Identity: Security Admin

• Service Account: User administrator to block AAD sign-ins

• App Registration: Microsoft graph User Read Access Windows Defender ATP: Delegated AdvancedQuery, Alerts, Machine, User permissions

Author: Shivniel Gounder

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FShivniel%2FAzure%2Fmain%2FAzure%2520Sentinel%2FAzure%2520Sentinel%2520Playbooks%2FMDATP_ApprovalResponseAlerts%2Fazuredeploy.json)

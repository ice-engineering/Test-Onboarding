Description: Azure Sentinel playbook to automate high severity incidents by running AV scan, threat hunting malicious detected hashes, collect investigate package and disable Azure AD sign-in.

Permissions required:
•	Azure Sentinel playbook: Azure Sentinel Contributor 

•	Managed Identity: Security Admin

•	Service Account: User administrator to block AAD sign-ins

•	App Registration: Microsoft graph User Read Access
Windows Defender ATP: Delegated AdvancedQuery, Alerts, Machine, User permissions


Author: Shivniel Gounder

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FShivniel%2FAzure%2Fmain%2FAzure%2520Sentinel%2FAzure%2520Sentinel%2520Playbooks%2FMDATP_AutoResponseHighAlerts%2Fazuredeploy.json)

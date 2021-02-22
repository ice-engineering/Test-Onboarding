Description: Azure Sentinel playbook to automate the initial incident response:

• Identity if the IP address were previously used throughout the cloud tenant
• Request Virus Total Check for the IP address
• Review Azure Sentinel Entity Behaviour Analytics
• Request IP Quality Score
• Request HIBP results for the email address

SOC team will be sent an email to approve or reject the email to close the Sentinel incident if identified as False Positive.

Permissions required:

• Azure Sentinel playbook: Azure Sentinel Contributor

Author: Shivniel Gounder and Debac Manikandan

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FShivniel%2FAzure%2Fmain%2FAzure%2520Sentinel%2FAzure%2520Sentinel%2520Playbooks%2FInitialTriage%2Fazuredeploy.json)

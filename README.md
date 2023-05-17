# Introduction

The purpose of this GitHub is to illustrate how to do the [password credentials grants](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth-ropc) in Azure Active Directory and get a valid JWT token to call a protected Azure Function.

Keep in mind **Microsoft doesn't recommend to use this authentication flow**, but this is to illustrate some legacy software communicating using SOAP.

The SOAP message will look something like this:

```xml
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:u="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
    <s:Header>
        <o:Security s:mustUnderstand="1" xmlns:o="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
            <u:Timestamp u:Id="_0">
                <u:Created>2021-11-19T18:49:31.314Z</u:Created>
                <u:Expires>2021-11-19T18:54:31.314Z</u:Expires>
            </u:Timestamp>
            <o:UsernameToken u:Id="uuid-4454cb9c-d5f7-4309-b2ef-99062277674c-4">
                <o:Username>[Your username]</o:Username>
                <o:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">[Password]</o:Password>
            </o:UsernameToken>
        </o:Security>
    </s:Header>
    <s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <RCMR_IN000002UV01 ITSVersion="XML_1.0" xmlns="urn:hl7-org:v3">
           test
        </RCMR_IN000002UV01>
    </s:Body>
</s:Envelope>
```

The source system will have a service account in Azure Active Directory, basically here it's an old system that doesn't support OAuth2 and the active directory is sync with Azure Active Directory.  Keep in mind if MFA is activated on this service account in AAD this authentication won't work and you will need to use an alternative solution.

# Architecture


# Run this repository

First, fork this GitHub repository.

## Create Github Secrets

You will need to create some [GitHub repository secrets](https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-encrypted-secrets-for-your-repository-and-organization-for-codespaces#adding-secrets-for-a-repository) first.  Here the list of secrets you will need to create.

| Secret Name | Value | Link
|-------------|-------|------|
| AZURE_CREDENTIALS | The service principal credentials needed in the Github Action | [GitHub Action](https://github.com/marketplace/actions/azure-login)
| AZURE_SUBSCRIPTION | The subscription ID where the resources will be created |
| CLIENT_ID | The ID of the App Registration |
| CLIENT_SECRET | The secret of the App Registration |
| PUBLISHER_EMAIL | The email associated to the admin of APIM |
| PUBLISHER_NAME | The company name of the APIM (can be anything like Contoso) |
| IDP_TOKEN_ENDPOINT | The token endpoint of the identity provider, in this case Azure Active Directory |


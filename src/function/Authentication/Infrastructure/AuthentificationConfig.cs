using System;

namespace Contoso;

public class AuthentificationConfig
{
    public string Scope => Environment.GetEnvironmentVariable("AzureAD:Scope");
    public string Authority => Environment.GetEnvironmentVariable("AzureAD:Authority");
    public string ClientId => Environment.GetEnvironmentVariable("AzureAD:ClientId");
}
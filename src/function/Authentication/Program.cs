using Contoso;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var host = new HostBuilder()
    .ConfigureFunctionsWorkerDefaults()
    .ConfigureAppConfiguration(builder => 
    { 
        builder.AddJsonFile("local.settings.json", optional: true, reloadOnChange: false)
               .AddEnvironmentVariables();
    })
    .ConfigureServices(s => 
    {
        s.AddSingleton<IIdentityProviderService, IdentityProviderService>();
        //s.AddSingleton(new AuthentificationConfig());
    })    
    .Build();



host.Run();

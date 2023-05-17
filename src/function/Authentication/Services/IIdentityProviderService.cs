using System.Threading.Tasks;

namespace Contoso;

public interface IIdentityProviderService
{
    Task<string> AcquireTokenAsync(string username, string password);
}


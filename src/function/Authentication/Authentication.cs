using System.Net;
using System.Xml;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Contoso
{
    public class Authentication
    {
        private readonly ILogger _logger;
        private readonly IIdentityProviderService _identityProviderService;

        public Authentication(ILoggerFactory loggerFactory, IIdentityProviderService identityProviderService)
        {
            _logger = loggerFactory.CreateLogger<Authentication>();
            _identityProviderService = identityProviderService;
        }

        [Function("GetJwtTokenFromSoapHeader")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequestData req)
        {
            try
            {
                _logger.LogInformation("Processing authentication soap message");
                HttpResponseData response = null;
                string requestBody = await new StreamReader(req.Body).ReadToEndAsync();

                if (string.IsNullOrEmpty(requestBody))
                {
                    response = req.CreateResponse(HttpStatusCode.BadRequest);
                    return response;
                }

                // Load the SOAP msg
                var xmlDocument = new XmlDocument();
                xmlDocument.LoadXml(requestBody);

                // Get username and pwd
                var root = xmlDocument.DocumentElement;
                var username = root.GetElementsByTagName("o:Username");
                var password = root.GetElementsByTagName("o:Password");

                if (username == null || password == null || username.Count == 0 || password.Count == 0)
                {
                    response = req.CreateResponse(HttpStatusCode.BadRequest);
                    return response;
                }

                // Get the JWT token
                var token = await _identityProviderService.AcquireTokenAsync(username[0].InnerText, password[0].InnerText);

                response = req.CreateResponse(HttpStatusCode.OK);
                await response.WriteStringAsync(token);
                return response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, ex.Message);
                var response = req.CreateResponse(HttpStatusCode.InternalServerError);
                return response;
            }

        }
    }
}

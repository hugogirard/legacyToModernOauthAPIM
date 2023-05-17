using System.IO;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;

namespace Contoso
{
    public class ProcessSoapMessage
    {
        private readonly ILogger<ProcessSoapMessage> _logger;

        public ProcessSoapMessage(ILogger<ProcessSoapMessage> log)
        {
            _logger = log;
        }

        [FunctionName("ProcessSoapMessage")]
        [OpenApiOperation(operationId: "ProcessSoapMessage", tags: new[] { "name" })]        
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "text/plain", bodyType: typeof(string), Description = "The OK response")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            string responseMessage = "Function working";

            return new OkObjectResult(responseMessage);
        }
    }
}


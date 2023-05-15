param apimName string
param functionName string

resource apim 'Microsoft.ApiManagement/service@2022-08-01' existing = {
  name: apimName
}

resource function 'Microsoft.Web/sites@2022-09-01' existing = {
  name: functionName
}

resource functionBackend 'Microsoft.ApiManagement/service/backends@2022-09-01-preview' = {
  parent: apim
  name: functionName
  properties: {
    description: functionName
    protocol: 'http'
    url: 'https://{{functionName}}.azurewebsites.net/api/'
    resourceId: function.id
  }
}

output functionBackendName string = functionBackend.name

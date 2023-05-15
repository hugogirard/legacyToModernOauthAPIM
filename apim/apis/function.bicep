param functionName string
param apimName string

resource apiManagement 'Microsoft.ApiManagement/service@2022-08-01' existing = {
  name: apimName
}

resource apis 'Microsoft.ApiManagement/service/apis@2022-09-01-preview' = { 
  parent: apiManagement
  name: functionName
  properties: {
    displayName: functionName
    apiRevision: '1'
    serviceUrl: 'https/${functionName}.azurewebsites.net/api/ProtectFunction'
    description: 'Function API ${functionName}'
    path: 'func'
    subscriptionRequired: true
    protocols: [
      'https'
    ]
    subscriptionKeyParameterNames: {
      header: 'Ocp-Apim-Subscription-Key'
      query: 'subscription-key'
    }
    isCurrent: true
  }
}

resource operationFunction 'Microsoft.ApiManagement/service/apis/operations@2022-09-01-preview' = {
  parent: apis
  name: 'SendSoapMessage'
  properties: {
    displayName: 'SendSoapMessage'
    method: 'POST'
    urlTemplate: '/'
  }
}

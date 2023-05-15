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
    serviceUrl: 'https://${functionName}.azurewebsites.net/api/'
    description: 'Function API ${functionName}'
    path: 'func'
    subscriptionRequired: true
    format: 'openapi+json'
    value: loadTextContent('./swagger.json')
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


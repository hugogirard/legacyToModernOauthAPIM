param functionName string
param backend string

resource backendResource 'Microsoft.ApiManagement/service/backends@2022-09-01-preview' existing = {
  name: backend
}

resource apis 'Microsoft.ApiManagement/service/apis@2022-09-01-preview' = {
  parent: backendResource
  name: functionName
  properties: {
    displayName: functionName
    apiRevision: '1'
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

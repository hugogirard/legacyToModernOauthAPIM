param functionName string
param apimName string

var url = 'https://${functionName}.azurewebsites.net/api/'
var operationName = 'ProcessSoapMessage'

resource apiManagement 'Microsoft.ApiManagement/service@2022-08-01' existing = {
  name: apimName
}

resource apis 'Microsoft.ApiManagement/service/apis@2022-09-01-preview' = { 
  parent: apiManagement
  name: functionName
  properties: {
    displayName: 'ProcessSoapMessage'
    apiRevision: '1'
    serviceUrl: url
    description: 'Function API ${functionName}'
    path: 'func'
    subscriptionRequired: false
    format: 'openapi+json'
    value: loadTextContent('./swagger.json')
    protocols: [
      'https'
    ]
    isCurrent: true
  }
}

resource policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-09-01-preview' = {  
  name: '${apiManagement.name}/${apis.name}/${operationName}/policy'
  properties: {
    format: 'rawxml'
    value: loadTextContent('./policy.xml')
  }
}

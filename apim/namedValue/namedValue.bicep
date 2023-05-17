@secure()
param clientId string
@secure()
param clientSecret string
@secure()
param idpTokenEndpoint string
@secure()
param scope string

param apimName string

resource apiManagement 'Microsoft.ApiManagement/service@2022-08-01' existing = {
  name: apimName
}

resource clientIdNamedValue 'Microsoft.ApiManagement/service/namedValues@2022-09-01-preview' = {
  parent: apiManagement
  name: 'clientId'
  properties: {
    displayName: 'clientId'
    value: clientId
    secret: true
  }
}



resource clientSecretNamedValue 'Microsoft.ApiManagement/service/namedValues@2022-09-01-preview' = {
  parent: apiManagement
  name: 'clientSecret'
  properties: {
    displayName: 'clientSecret'
    value: clientSecret
    secret: true
  }
}

resource idpTokenEndpointNamedValue 'Microsoft.ApiManagement/service/namedValues@2022-09-01-preview' = {
  parent: apiManagement
  name: 'idpTokenEndpoint'
  properties: {
    displayName: 'idpTokenEndpoint'
    value: idpTokenEndpoint
    secret: true
  }
}

resource scopeNamedValue 'Microsoft.ApiManagement/service/namedValues@2022-09-01-preview' = {
  parent: apiManagement
  name: 'scope'
  properties: {
    displayName: 'scope'
    value: scope
    secret: true
  }
}

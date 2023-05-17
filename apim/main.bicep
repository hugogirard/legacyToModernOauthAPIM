param apimName string
param functionNameProcessMsg string
param functionNameAuth string
@secure()
param clientId string
@secure()
param clientSecret string
@secure()
param idpTokenEndpoint string
@secure()
param scope string

module namedValues 'namedValue/namedValue.bicep' = {
  name: 'namedValues'
  params: {
    apimName: apimName
    clientId: clientId
    clientSecret: clientSecret
    idpTokenEndpoint: idpTokenEndpoint
    scope: scope
    functionName: functionNameAuth
  }
}

module functionApi 'apis/processSoapMessage/api.bicep' = {
  name: 'functionApi'
  params: {
    apimName: apimName
    functionName: functionNameProcessMsg
  }
}

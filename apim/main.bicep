param apimName string
param functionName string

module functionApi 'apis/processSoapMessage/api.bicep' = {
  name: 'functionApi'
  params: {
    apimName: apimName
    functionName: functionName
  }
}

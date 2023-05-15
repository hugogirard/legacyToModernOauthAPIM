param apimName string
param functionName string

module functionApi 'apis/function.bicep' = {
  name: 'functionApi'
  params: {
    apimName: apimName
    functionName: functionName
  }
}

param apimName string
param functionName string


module backendFunction 'backend/backend.bicep' = {
  name: 'backendFunction'
  params: {
    apimName: apimName
    functionName: functionName
  }
}

module functionApi 'apis/function.bicep' = {
  name: 'functionApi'
  params: {
    backend: backendFunction.outputs.functionBackendName
    functionName: functionName
  }
}

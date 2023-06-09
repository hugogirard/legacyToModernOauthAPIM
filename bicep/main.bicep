targetScope='subscription'

param location string
@secure()
param publisherEmail string
@secure()
param publisherName string

var rgName = 'rg-apim-legacy-flow'

var suffix = uniqueString(rg.id)

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module monitoring 'modules/monitoring/monitoring.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'monitoring'
  params: {
    location: location
    suffix: suffix
  }
}

module function 'modules/function/function.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'function'
  params: {
    location: location
    suffix: suffix
    appInsightName: monitoring.outputs.appInsightName
  }
}

module redis 'modules/cache/redis.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'redis'
  params: {
    location: location
    suffix: suffix
  }
}

module apim 'modules/apim/apim.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'apim'
  params: {
    appInsightName: monitoring.outputs.appInsightName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
    suffix: suffix
  }
}

output functionNameProcessMessage string = function.outputs.functionNameProcessMessage
output apimName string = apim.outputs.apimName
output rgName string = rg.name

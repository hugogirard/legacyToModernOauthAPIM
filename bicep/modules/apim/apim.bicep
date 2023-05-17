param location string
param suffix string
param appInsightName string
@secure()
param publisherEmail string
@secure()
param publisherName string

resource appInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightName
}

resource apiManagement 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: 'api-${suffix}'
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName              
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource apimName_appInsightsObject_name 'Microsoft.ApiManagement/service/loggers@2019-01-01' = {
  parent: apiManagement
  name: appInsights.name
  properties: {
    loggerType: 'applicationInsights'
    resourceId: appInsights.id
    credentials: {
      instrumentationKey: appInsights.properties.InstrumentationKey
    }
  }
}

output apimName string = apiManagement.name

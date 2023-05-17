param location string
param suffix string

resource redisCache 'Microsoft.Cache/Redis@2020-06-01' = {
  name: 'cache-${suffix}'
  location: location
  properties: {
    enableNonSslPort: false        
    sku: {
      capacity: 0
      family: 'C'
      name: 'Basic'
    }
  }
}

output redisCacheId string = redisCache.id

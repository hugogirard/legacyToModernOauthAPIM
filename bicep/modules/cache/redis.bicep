param location string
param suffix string

resource redisCache 'Microsoft.Cache/Redis@2020-06-01' = {
  name: 'cache-${suffix}'
  location: location
  properties: {
    enableNonSslPort: false
    minimumTlsVersion: '1.2'
    sku: {
      capacity: 1
      family: 'Basic'
      name: 'Basic'
    }
  }
}

output redisCacheId string = redisCache.id

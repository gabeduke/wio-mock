# Wio-Mock

Wio-mock is a small server that mocks the response for wio sensor data so that it may be developed against without the need for an API key.

## Usage

### Run

### Scratch

```json
{
  "name": "leetNode1",
  "well_known": [
    "GET /v1/node/GroveBaroBMP085I2C1/temperature -> float temperature",
    "GET /v1/node/GroveBaroBMP085I2C1/altitude -> float altitude",
    "GET /v1/node/GroveBaroBMP085I2C1/pressure -> int32_t pressure",
    "GET /v1/node/GroveTempHumD0/humidity -> float humidity",
    "GET /v1/node/GroveTempHumD0/temperature -> float celsius_degree",
    "GET /v1/node/GroveTempHumD0/temperature_f -> float fahrenheit_degree"
  ]
}
```

```json
{
  "name": "leetNode2",
  "well_known": [
    "GET /v1/node/GroveAirqualityA0/quality -> int quality",
    "GET /v1/node/GroveDigitalLightI2C0/lux -> uint32_t lux"
  ]
}

```
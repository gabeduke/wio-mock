package main

import (
	"fmt"
	log "github.com/apex/log"
	"github.com/gin-gonic/gin"

	"math/rand"
	"net/http"
	"os"
)

func main() {
	r := rand.New(rand.NewSource(99))

	port := os.Getenv("PORT")
	if port == "" {
		port = "8081"
	}

	router := gin.Default()

	baro := router.Group("/v1/node/GroveBaroBMP085I2C1")
	tempHum := router.Group("/v1/node/GroveTempHumD0")
	digLight := router.Group("/v1/node/GroveDigitalLightI2C0")
	airQuality := router.Group("/v1/node/GroveAirqualityA0")

	// baro Group
	baro.GET("/temperature", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"temperature": r.Float32()})
	})

	baro.GET("/altitude", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"altitude": r.Float32()})
	})

	baro.GET("/pressure", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"pressure": r.Int31()})
	})

	// tempHum Group
	tempHum.GET("/humidity", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"humidity": r.Float32()})
	})

	tempHum.GET("/temperature", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"celsius_degree": r.Float32()})
	})

	tempHum.GET("/temperature_f", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"fahrenheit_degree": r.Float32()})
	})

	// airQuality Group
	airQuality.GET("/quality", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"quality": r.Int()})
	})

	// digLight Group
	digLight.GET("/lux", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"lux": r.Uint32()})
	})



	// run
	log.WithField("Port", port).Info("Starting service..")
	err := router.Run(fmt.Sprintf(":%s", port))
	if err != nil {
		log.Fatal(err.Error())
	}
}

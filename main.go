package main

import (
	"github.com/gin-gonic/gin"
	"os"
	"io"
	"log"
)

type WeatherEntry struct {
  Baromin string `json:"baromin"`
}

func main() {
  r := gin.Default()

  // Log
  f, _ := os.Create("gin.log")
  gin.DefaultWriter = io.MultiWriter(f)

  // Routes
	r.GET("/", func(c *gin.Context) {
    c.String(200, "WeatherData v1")
	})
	r.POST("/", func(c *gin.Context) {
    baromin := c.DefaultQuery("baromin", "")

    w := WeatherEntry{baromin}

    log.Println("Baromin: " + w.Baromin)
    c.String(200, "Ok, Thank You.")
	})

  r.Run(":9090")
}

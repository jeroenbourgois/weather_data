package main

import (
  _ "github.com/mattn/go-sqlite3"

  "database/sql"
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
	"io"
	"log"
)

var DB *sql.DB

type WeatherEntry struct {
  Id      int     `json:"id"`
  Baromin string  `json:"baromin"`
}

func main() {
  r := gin.Default()

  ConnectDb()

  // Log
  f, _ := os.Create("gin.log")
  gin.DefaultWriter = io.MultiWriter(f)

  // Routes
	r.GET("/", func(c *gin.Context) {
    c.String(200, "WeatherData v1")
	})

	r.GET("/weatherstation/updateweatherstation.php", func(c *gin.Context) {
    c.String(200, "WeatherData weathersstation call\n")
    baromin := c.DefaultQuery("baromin", "")

    var w WeatherEntry
    w.Baromin = baromin

    success, err := AddWeatherEntry(w)

    if success {
      c.String(http.StatusOK, "Ok")
    } else {
      c.String(http.StatusBadRequest, err.Error())
    }
	})

  port := getEnv("WEATHER_DATA_PORT", "9090")

  r.Run(":" + port)
}

// Helpers
func getEnv(key, fallback string) string {
    if value, ok := os.LookupEnv(key); ok {
        return value
    }
    return fallback
}

func ConnectDb() {
  // Connect to database
  db, err := sql.Open("sqlite3", "./weather_data.db")
	if err != nil {
		log.Fatal(err)
	}
	DB = db
}

func AddWeatherEntry(newEntry WeatherEntry) (bool, error) {
	tx, err := DB.Begin()
	if err != nil {
		return false, err
	}

	stmt, err := tx.Prepare("INSERT INTO entries (baromin) VALUES (?)")

	if err != nil {
		return false, err
	}

	defer stmt.Close()

	_, err = stmt.Exec(newEntry.Baromin)

	if err != nil {
		return false, err
	}

	tx.Commit()

	return true, nil
}

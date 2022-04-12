package main

import (
  _ "github.com/mattn/go-sqlite3"

  "database/sql"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
  "encoding/csv"
	"os"
	"io"
	"log"
)

var DB *sql.DB

type WeatherEntry struct {
  id              int       `json:"id"`
  action          string    `json:"action"`
  baromin         float64   `json:"baromin"`
  uv              float64   `json:"uv"`
  dewptf          float64   `json:"dewptf"`
  humidity        int       `json:"humidity"`
  indoorhumidity  int       `json:"indoorhumidity"`
  indoortempf     float64   `json:"indoortempf"`
  rainin          float64   `json:"rainin"`
  realtime        int       `json:"realtime"`
  rtfreq          int       `json:"rtfreq"`
  solarradiation  float64   `json:"solarradiation"`
  tempf           float64   `json:"tempf"`
  winddir         float64   `json:"winddir"`
  windgustmph     float64   `json:"windgustmph"`
  windspeedmph    float64   `json:"windspeedmph"`
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
    baromin := c.DefaultQuery("baromin", "0")
    action := c.DefaultQuery("action", "")
    uv := c.DefaultQuery("uv", "0")
    dewptf := c.DefaultQuery("dewptf", "0")
    humidity := c.DefaultQuery("humidity", "0")
    indoorhumidity := c.DefaultQuery("indoorhumidity", "0")
    indoortempf := c.DefaultQuery("indoortempf", "0")
    rainin := c.DefaultQuery("rainin", "0")
    realtime := c.DefaultQuery("realtime", "0")
    rtfreq := c.DefaultQuery("rtfreq", "0")
    solarradiation := c.DefaultQuery("solarradiation", "0")
    tempf := c.DefaultQuery("tempf", "0")
    winddir := c.DefaultQuery("winddir", "0")
    windgustmph := c.DefaultQuery("windgustmph", "0")
    windspeedmph := c.DefaultQuery("windspeedmph", "0")

    var w WeatherEntry
    if v, err := strconv.ParseFloat(baromin, 64); err == nil {
      w.baromin = v
    }
    w.action = action
    if v, err := strconv.ParseFloat(uv, 64); err == nil {
      w.uv = v
    }
    if v, err := strconv.ParseFloat(dewptf, 64); err == nil {
      w.dewptf = v
    }
    if v, err := strconv.Atoi(humidity); err == nil {
      w.humidity = v
    }
    if v, err := strconv.Atoi(indoorhumidity); err == nil {
      w.indoorhumidity = v
    }
    if v, err := strconv.ParseFloat(indoortempf, 64); err == nil {
      w.indoortempf = v
    }
    if v, err := strconv.ParseFloat(rainin, 64); err == nil {
      w.rainin = v
    }
    if v, err := strconv.Atoi(realtime); err == nil {
      w.realtime = v
    }
    if v, err := strconv.Atoi(rtfreq); err == nil {
      w.rtfreq = v
    }
    if v, err := strconv.ParseFloat(solarradiation, 64); err == nil {
      w.solarradiation = v
    }
    if v, err := strconv.ParseFloat(tempf, 64); err == nil {
      w.tempf = v
    }
    if v, err := strconv.ParseFloat(winddir, 64); err == nil {
      w.winddir = v
    }
    if v, err := strconv.ParseFloat(windgustmph, 64); err == nil {
      w.windgustmph = v
    }
    if v, err := strconv.ParseFloat(windspeedmph, 64); err == nil {
      w.windspeedmph = v
    }

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

  // Save to db
	stmt, err := tx.Prepare("INSERT INTO entries (action, baromin, uv, dewptf, humidity, indoorhumidity, indoortempf, rainin, realtime, rtfreq, solarradiation, tempf, winddir, windgustmph, windspeedmph) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,?)")

	if err != nil {
		return false, err
	}

	defer stmt.Close()

  res, err := stmt.Exec(newEntry.action, newEntry.baromin, newEntry.uv, newEntry.dewptf, newEntry.humidity, newEntry.indoorhumidity, newEntry.indoortempf, newEntry.rainin, newEntry.realtime, newEntry.rtfreq, newEntry.solarradiation, newEntry.tempf, newEntry.winddir, newEntry.windgustmph, newEntry.windspeedmph)

	if err != nil {
		return false, err
	}

  id, err := res.LastInsertId()

	if err != nil {
		return false, err
	}

	tx.Commit()

  // Also save to csv-style log file
  m := make(map[int]WeatherEntry)
  m[int(id)] = newEntry

  f, err := os.OpenFile("entries.csv", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
  if err != nil {
    // handle error
    log.Fatal(err)
  }
  defer f.Close()
  w := csv.NewWriter(f)
  defer w.Flush()

  for _, v := range m {
    r := make([]string, 0, 2)
    r = append(r, v.action)
    err := w.Write(r)
    if err != nil {
      // handle error
      log.Fatal(err)
    }
  }

	return true, nil
}

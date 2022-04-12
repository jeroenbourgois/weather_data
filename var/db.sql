CREATE TABLE "entries" (
	"id"	            INTEGER,
  "action"          TEXT,
  "baromin"         NUMERIC,
  "uv"              NUMERIC,  
  "dewptf"          NUMERIC,  
  "humidity"        INTEGER,      
  "indoorhumidity"  INTEGER,      
  "indoortempf"     NUMERIC,  
  "rainin"          NUMERIC,  
  "realtime"        INTEGER,      
  "rtfreq"          INTEGER,      
  "solarradiation"  NUMERIC,  
  "tempf"           NUMERIC,  
  "winddir"         NUMERIC,  
  "windgustmph"     NUMERIC,  
  "windspeedmph"    NUMERIC,  
	PRIMARY KEY("id" AUTOINCREMENT)
)

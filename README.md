# WeatherData

To be able run the release, an environment variable `DB` needs to be set
and should point to a SQLite db file.

For example:

```
DB=/home/pi/weather_data.db sudo /opt/app/weather_data/_build/prod/rel/weather_data/bin/weather_data start
```

# Dev

Just clone the repo. Make sure to set all env vars, take a look at the `.env.example` file.

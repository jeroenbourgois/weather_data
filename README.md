# WeatherData

To be able run the release, an environment variable `DB` needs to be set
and should point to a SQLite db file.

For example:

```
DB=/home/pi/weather_data.db sudo /opt/app/weather_data/_build/prod/rel/weather_data/bin/weather_data start
```

# Dev

Just clone the repo. Make sure to set all env vars, take a look at the `.env.example` file.

# Deploy

Elixir releases can only be ran from the same host as it was build on. I did not want to bother with docker and all that, I just build the release on the Pi. It takes a while but I could care less, it needs to be done just once in a while.

Default port: 4000

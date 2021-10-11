use Mix.Config

config :weather_data, port: 80

config :logger,
  backends: [:console, {LoggerFileBackend, :file}],
  level: :info,
  format:
    "$date MIX_ENV=prod sudo /opt/app/weather_data/_build/prod/rel/weather_data/bin/weather_data start$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :logger, :file,
  path: "/var/log/weather_data.log",

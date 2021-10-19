use Mix.Config

config :weather_data, port: 80

config :logger,
  backends: [:console, {LoggerFileBackend, :file}],
  level: :info,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:user_id]

config :logger, :file, path: "/var/log/weather_data.log"

config :weather_data, WeatherData.Repo, database: System.fetch_env!("DB")

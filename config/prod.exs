import Config

config :weather_data, port: 4000

config :logger,
  backends: [:console, {LoggerFileBackend, :file}],
  level: :info,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:user_id]

config :logger, :file, path: "/home/pi/weather_data/weather_data.log"

config :weather_data, WeatherData.Repo, database: System.fetch_env!("DB")

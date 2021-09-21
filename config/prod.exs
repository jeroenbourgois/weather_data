use Mix.Config

config :weather_data, port: 80

config :logger,
  backends: [:console, {LoggerFileBackend, :file}]

config :logger, :file,
  path: "/var/log/weather_data.log",
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id],
  level: :debug


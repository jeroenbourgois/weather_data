use Mix.Config

config :weather_data, port: 80

config :logger,
  backends: [{LoggerFileBackend, :file}]

config :logger, :file,
  path: "log/weather_data.log",
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id],
  level: :debug


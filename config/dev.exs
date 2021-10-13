use Mix.Config

config :weather_data, port: 4001

config :logger,
  backends: [:console]

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  level: :debug

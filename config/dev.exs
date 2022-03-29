import Config

config :logger,
  backends: [:console]

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  level: :debug

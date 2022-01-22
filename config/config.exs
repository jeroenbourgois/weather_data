# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
import Config

config :weather_data,
  ecto_repos: [WeatherData.Repo]

config :weather_data, WeatherData.Repo, database: System.get_env("DB") || "weather_data.db"

import_config "#{Mix.env()}.exs"

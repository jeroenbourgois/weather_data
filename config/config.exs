# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :weather_data,
  ecto_repos: [WeatherData.Repo]

config :weather_data, WeatherData.Repo,
  database: System.fetch_env!("DB")

import_config "#{Mix.env()}.exs"

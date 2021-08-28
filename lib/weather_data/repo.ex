defmodule WeatherData.Repo do
  use Ecto.Repo, otp_app: :weather_data, adapter: Ecto.Adapters.SQLite3
end

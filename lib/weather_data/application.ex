defmodule WeatherData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WeatherData.Repo,
       {Plug.Cowboy, scheme: :http, plug: WeatherData.Endpoint, port: Application.get_env(:weather_data, :port)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeatherData.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

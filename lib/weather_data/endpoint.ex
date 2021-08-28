defmodule WeatherData.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  require Logger

  use Plug.Router

  alias WeatherData.Events

  plug(Plug.Logger)

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  # responsible for dispatching responses
  plug(:dispatch)

  get _, via: :get do
    Events.add_event(conn.params)
    send_resp(conn, 200, "")
  end
end

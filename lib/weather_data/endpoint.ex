defmodule WeatherData.Endpoint do
  require EEx

  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  require Logger

  use Plug.Router

  alias WeatherData.Events

  @template_dir "lib/weather_data/templates"

  plug(Plug.Logger)

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  # responsible for dispatching responses
  plug(:dispatch)

  get "/weatherstation/updateweatherstation.php" do
    Events.add_event(conn.params)
    send_resp(conn, 200, "Thanks")
  end

  get "/" do
    events = Events.get_last_events(50)
    last_seven_days = Events.get_last_seven_days()
    render(conn, :index, events: events, last_seven_days: last_seven_days)
  end

  match _ do
    Logger.info("[INCOMING] - #{inspect(conn)}")
    send_resp(conn, 404, "Page not found")
  end

  EEx.function_from_file(:defp, :index, @template_dir <> "/index.html.eex", [:assigns])

  defp render(%{status: status} = conn, :index, assigns) do
    body = index(assigns)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(status || 200, body)
  end
end

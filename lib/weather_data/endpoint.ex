defmodule WeatherData.Endpoint do
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

  get _ do
    events = Events.get_last_events(10)
    render(conn, "index.html", [events: events])
  end

  defp render(%{status: status} = conn, template, assigns) do
    body =
    @template_dir
    |> Path.join(template)
    |> String.replace_suffix(".html", ".html.eex")
    |> EEx.eval_file(assigns)

    send_resp(conn, (status || 200), body)
  end
end

defmodule WeatherData.Events do
  import Ecto.Query, warn: false

  alias WeatherData.Event
  alias WeatherData.Repo

  def add_event(payload) when is_map(payload) do
    payload = cleanup_uv(payload)

    %Event{}
    |> Event.changeset_new(payload)
    |> Repo.insert()
  end

  defp cleanup_uv(%{"UV" => uv} = payload) do
    payload
    |> Map.put("uv", uv)
    |> Map.delete("UV")
  end

  defp cleanup_uv(payload), do: payload

  def get_last_events(count) do
    Event
    |> order_by(desc: :id)
    |> limit(^count)
    |> Repo.all()
  end

  def getget() do
    from(
      e in Event,
      select: %{indoortempf: avg(e.indoortempf), inserted_at: max(e.inserted_at)},
      where: not is_nil(e.indoortempf),
      group_by: e.inserted_at
    )
    |> Repo.all()
  end
end

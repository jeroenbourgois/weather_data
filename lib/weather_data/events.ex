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

  @spec get_last_events(integer) :: [Event.t()]
  def get_last_events(count) when is_integer(count) do
    Event
    |> order_by(desc: :id)
    |> limit(^count)
    |> Repo.all()
  end

  @spec get_last_seven_days() :: [Event.t()]
  def get_last_seven_days() do
    now = NaiveDateTime.utc_now()
    last_week = NaiveDateTime.add(now, 60 * 60 * 24 * 7 * -1)

    from(
      e in Event,
      select: %{
        indoortempf: avg(e.indoortempf),
        indoortempf_max: max(e.indoortempf),
        indoortempf_min: min(e.indoortempf),
        tempf: avg(e.tempf),
        tempf_max: max(e.tempf),
        tempf_min: min(e.tempf),
        baromin: avg(e.baromin),
        uv: avg(e.uv),
        humidity: avg(e.humidity),
        humidity_max: max(e.humidity),
        humidity_min: min(e.humidity),
        rainin: avg(e.rainin),
        rainin_max: max(e.rainin),
        rainin_min: min(e.rainin),
        inserted_at: fragment("MAX(DATE(?))", e.inserted_at)
      },
      where: not is_nil(e.indoortempf),
      where: fragment("DATE(?) BETWEEN DATE(?) AND DATE(?)", e.inserted_at, ^last_week, ^now),
      group_by: fragment("DATE(?)", e.inserted_at)
    )
    |> Repo.all()
  end
end

defmodule WeatherData.Events do

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
end

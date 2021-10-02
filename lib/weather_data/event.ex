defmodule WeatherData.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field(:action, :string)
    field(:baromin, :decimal)
    field(:uv, :decimal)
    field(:dewptf, :decimal)
    field(:humidity, :integer)
    field(:indoorhumidity, :integer)
    field(:indoortempf, :decimal)
    field(:rainin, :decimal)
    field(:realtime, :integer)
    field(:rtfreq, :integer)
    field(:solarradiation, :decimal)
    field(:tempf, :decimal)
    field(:winddir, :decimal)
    field(:windgustmph, :decimal)
    field(:windspeedmph, :decimal)
    # field :prcp,    :float, default: 0.0

    timestamps()
  end

  @attrs ~w(action baromin uv dewptf humidity indoorhumidity indoortempf rainin realtime rtfreq solarradiation tempf winddir windgustmph windspeedmph)a

  @doc false
  def changeset_new(%__MODULE__{} = event, attrs) do
    cast(event, attrs, @attrs)
  end
end

defmodule WeatherData.Repo.Migrations.CreateEvents do
  use Ecto.Migration
  import Ecto.Changeset

  def change do
    create table(:events) do
      add :action,          :string
      add :baromin,         :decimal
      add :uv,              :decimal
      add :dewptf,          :decimal
      add :humidity,        :integer
      add :indoorhumidity,  :integer
      add :indoortempf,     :decimal
      add :rainin,          :decimal
      add :realtime,        :integer
      add :rtfreq,          :integer
      add :solarradiation,  :decimal
      add :tempf,           :decimal
      add :winddir,         :decimal
      add :windgustmph,     :decimal
      add :windspeedmph,    :decimal

      timestamps()
    end
  end
end

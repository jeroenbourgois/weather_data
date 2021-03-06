defmodule WeatherData.ViewHelpers do
  alias Decimal, as: D

  def fahrenheit_to_celcius(nil), do: Decimal.new(0)
  def fahrenheit_to_celcius(f), do: f |> D.sub(32) |> D.div(D.new("1.8")) |> D.round(2)

  def mph_to_kph(nil), do: Decimal.new(0)
  def mph_to_kph(m), do: m |> D.mult(D.new("1.609344")) |> D.round(2)
end

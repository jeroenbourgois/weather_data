defmodule WeatherDataTest do
  use ExUnit.Case
  doctest WeatherData

  test "greets the world" do
    assert WeatherData.hello() == :world
  end
end

defmodule WeathersSpikeTest do
  use ExUnit.Case
  doctest WeathersSpike

  test "greets the world" do
    assert WeathersSpike.hello() == :world
  end
end

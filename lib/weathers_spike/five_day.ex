defmodule WeatherSpike.FiveDay do
  @moduledoc """
  A structure of 5 day / 3 hour forecast data with OpenWeatherMap.

  see [5 day weather forecast - OpenWeatherMap](https://openweathermap.org/forecast5)
  """

  defstruct [
    :cod,
    :message,
    :city,
    :cnt,
    :list
  ]

  defmodule City do
    defstruct [
      :id,
      :name,
      :coord,
      :country
    ]

    defmodule Coord do
      defstruct [
        :lat,
        :lon
      ]
    end
  end

  defmodule Item do
    defstruct [
      :dt,
      :main,
      :weather,
      :clouds,
      :wind,
      :rain,
      :snow,
      :dt_txt
    ]

    defmodule Main do
      defstruct [
        :temp,
        :temp_min,
        :temp_max,
        :pressure,
        :sea_level,
        :grnd_level,
        :humidity,
        :temp_kf
      ]
    end

    defmodule Weather do
      defstruct [
        :id,
        :main,
        :description,
        :icon
      ]
    end

    defmodule Clouds do
      defstruct [
        :all
      ]
    end

    defmodule Wind do
      defstruct [
        :speed,
        :deg
      ]
    end

    defmodule Volume do
      defstruct [
        :"3h"
      ]
    end
  end

  @doc """
  Decode a JSON string of 5 day / 3 hour forecast data.
  """
  def decode(source) do
    source
    |> Poison.decode(
      as: %WeatherSpike.FiveDay{
        city: %WeatherSpike.FiveDay.City{
          coord: %WeatherSpike.FiveDay.City.Coord{}
        },
        list: [
          %WeatherSpike.FiveDay.Item{
            main: %WeatherSpike.FiveDay.Item.Main{},
            weather: [%WeatherSpike.FiveDay.Item.Weather{}],
            clouds: %WeatherSpike.FiveDay.Item.Clouds{},
            wind: %WeatherSpike.FiveDay.Item.Wind{},
            rain: %WeatherSpike.FiveDay.Item.Volume{},
            snow: %WeatherSpike.FiveDay.Item.Volume{}
          }
        ]
      }
    )
  end
end

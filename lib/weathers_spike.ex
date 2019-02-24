defmodule WeathersSpike do
  @moduledoc """
  Documentation for WeathersSpike.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WeathersSpike.hello()
      :world

  """
  def hello do
    :world
  end

  defstruct [:appid]

  def new(opts \\ []) when is_list(opts) do
    appid =
      case opts[:appid] do
        nil -> System.get_env("APPID")
        appid -> appid
      end

    %WeathersSpike{appid: appid}
  end

  def get_forecast(%WeathersSpike{appid: appid}) do
    url = "http://api.openweathermap.org/data/2.5/forecast?q=Tokyo,jp&appid=#{appid}"
    {:ok, resp} = HTTPoison.get(url)

    resp.body
    |> decode_forecast()
  end

  def decode_forecast(source) do
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

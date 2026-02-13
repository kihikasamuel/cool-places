defmodule CoolPlaces.Wrappers.Geolocation do
  @moduledoc """
  Utility for looking up IP address information.
  Uses IP-API.com (free for non-commercial use).
  """

  use CoolPlaces.Utils.HTTPClient

  require Logger

  @base_url "https://ip-api.com/json/"
  @headers [{"Content-Type", "application/json"}]

  def lookup(ip) when is_binary(ip) do
    url = @base_url <> ip

    result =
      request(:get, url, nil, @headers, [])
      |> parse_response()

    Logger.info("Lookup: #{inspect(result, pretty: true)}")
  end

  defp parse_response({:ok, response}) do
    parse_data(response)
  end

  defp parse_response({:error, reason}), do: {:error, reason}

  defp parse_data(data) do
    %{
      latitude: data["lat"],
      longitude: data["lon"],
      city: data["city"],
      region: data["regionName"],
      country: data["country"],
      country_code: data["countryCode"],
      timezone: data["timezone"]
    }
  end

  def hash_ip(ip) do
    :crypto.hash(:sha256, ip) |> Base.encode16()
  end
end

defmodule CoolPlaces.Utils.HTTPClient.Finch do
  @moduledoc """
  HTTP client using Finch
  """
  @behaviour CoolPlaces.Utils.HTTPClient


  @impl CoolPlaces.Utils.HTTPClient
  def request(method, url, body, headers, options) do
    method
    |> Finch.build(url, headers, body, options)
    |> Finch.request(CoolPlaces.Finch)
  end
end

defmodule CoolPlaces.Utils.HTTPClient.Finch do
  @moduledoc """
  HTTP client using Finch
  """
  @behaviour CoolPlaces.Utils.HTTPClient
  require Finch

  import CoolPlaces.Utils.HTTPClient, only: [process_reponse: 1]


  @impl true
  def request(method, url, headers, body, options) do
    method
    |> Finch.build(url, headers, body, options)
    |> Finch.request(CoolPlaces.Finch)
    |> process_reponse()
  end
end

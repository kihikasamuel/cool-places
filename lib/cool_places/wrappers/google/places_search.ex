defmodule CoolPlaces.Wrappers.Google.PlacesSearch do
  @doc """
  This module helps query Google API's for places

  Implementation for places search can be done with either Gemini Flash or Places API
  """

  use CoolPlaces.Utils.HTTPClient

  require Logger

  @headers [{"Content-Type", "application/json"}]

  def config(key), do: config() |> Keyword.fetch!(key)
  def config(), do: Application.fetch_env!(:cool_places, __MODULE__)

  def search(keyword) do
    search_prompt =
      "Act as a geocoding API. Provide a JSON array of 5 real-world place suggestions matching #{keyword}. Each object MUST have: name, address, lat, lng, country, category, city, town, and postal_code. Return ONLY the JSON array."

    body =
      Jason.encode!(%{
        "contents" => %{"parts" => [%{"text" => search_prompt}]},
        "generationConfig" => %{"responseMimeType" => "application/json"}
      })

    headers = @headers

    call(:post, body, headers)
  end

  def generate_itinerary(destination, plan_period \\ 3) do
    prompt =
      "Create a luxurious #{plan_period}-day travel itinerary for #{destination}. Use Header 3 for days. Markdown format."

    body =
      Jason.encode!(%{
        "contents" => %{"parts" => [%{"text" => prompt}]},
        "generationConfig" => %{"responseMimeType" => "application/json"}
      })

    headers = @headers

    call(:post, body, headers, [])
  end

  defp call(method, body, headers, options \\ []) do
    base_uri = config(:base_url) |> URI.parse()
    model = config(:model)
    query_params = URI.encode_query(%{"key" => config(:api_key)})
    path = [base_uri.path || "/", "v1beta/models/", model, "?#{query_params}"] |> Path.join()

    uri = %{base_uri | path: path} |> URI.to_string()

    request(method, uri, body, headers, options)
    |> parse_response
  end

  defp parse_response({:ok, %{"candidates" => [hd | _]} = _response}) do
    hd
    |> Map.get("content")
    |> parse_response()
  end

  defp parse_response(%{"parts" => [hd | _]} = _content) do
    data =
      hd
      |> Map.get("text")

    with {:ok, data} <- Jason.decode(data) do
      data =
        data
        |> Enum.map(fn item ->
          item
          |> Map.put("id", generate_ids())
        end)

      {:ok, data}
    else
      _ ->
        Logger.info("Unable to decode search results")
        {:ok, []}
    end
  end

  defp generate_ids(len \\ 16), do: :crypto.strong_rand_bytes(len) |> Base.encode16()
end

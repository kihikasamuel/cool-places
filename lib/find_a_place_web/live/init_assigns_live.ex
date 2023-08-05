defmodule FindAPlaceWeb.InitAssignsLive do
  import Phoenix.LiveView

  alias FindAPlace.Places

  @cache_name :places_cache
  @default_ttl 1_000 #5 min = 300000

  def on_mount(:home, _params, _session, socket) do
    {:cont, assign(socket, :active_item, :home)}
  end

  def on_mount(:about, _params, _session, socket) do
    {:cont, assign(socket, :active_item, :about)}
  end

  def on_mount(:load_places, _params, _session, socket) do
    places= get_or_store_in_cache("listing", (fn -> Places.list_places() end))
    # places = Places.list_places()
    {:cont, socket |> assign(:places, places)}
  end

  defp get_or_store_in_cache(key, fun) do
    case Cachex.get(@cache_name, key) do
      {:ok, nil} ->
        places = fun.()
        Cachex.put(@cache_name, key, places, ttl: @default_ttl)
        places
      {:ok, result} ->
        # IO.inspect(result, label: "Cached listing")
        result
    end
  end

  def on_inserted(place) do
    {:ok, true} = Cachex.put(@cache_name, place.id, place)
    true
  end

end

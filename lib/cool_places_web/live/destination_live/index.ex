defmodule CoolPlacesWeb.DestinationsLive.Index do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Destinations

  @options [page: 1, per_page: 20]

  @impl true
  def mount(_params, _session, socket) do
    search_form = changeset(%{}) |> to_form()

    socket =
      socket
      |> assign(search_form: search_form, destinations_count: 0, page: 1)

    {:ok, stream(socket, :destinations, [], reset: true)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    destinations = Destinations.list_destinations()

    socket
    |> assign(
      page_title: "Discover Your Next Adventure",
      categories: ["Beach", "Mountain", "Desert", "Historic"],
      destinations_count: length(destinations.entries)
    )
    |> stream(:destinations, destinations, reset: true)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    destination = Destinations.get_destination!(id)
    {:ok, _} = Destinations.delete_destination(destination)
    stream_delete(socket, :destinations, destination)
    {:noreply, socket}
  end

  def handle_event("search_destinations", params, socket) do
    opts =
      @options
      |> Keyword.merge(page: socket.assigns.page)

    results =
      Destinations.filtered_query(params)
      |> Destinations.list_destinations(opts)

    {:noreply,
     socket
     |> assign(destinations_count: length(results.entries))
     |> stream(:destinations, results, reset: true)}
  end

  defp changeset(params) do
    %{}
    |> Map.put("destination", Map.get(params, "destination", ""))
    |> Map.put("city", Map.get(params, "city", ""))
    |> Map.put("category", Map.get(params, "category", ""))
  end
end

defmodule CoolPlacesWeb.DestinationsLive.Index do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Destinations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :destinations, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(page_title: "Find Your Next Adventure")
    |> stream(:destinations, Destinations.list_destinations())
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    destination = Destinations.get_destination!(id)
    {:ok, _} = Destinations.delete_destination(destination)
    stream_delete(socket, :destinations, destination)
    {:noreply, socket}
  end
end

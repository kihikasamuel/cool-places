defmodule CoolPlacesWeb.DestinationsLive.Show do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Destinations

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(is_loading: false, travel_plan: nil)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Destination Details")
     |> assign(:destination, Destinations.get_destination!(id))}
  end
end

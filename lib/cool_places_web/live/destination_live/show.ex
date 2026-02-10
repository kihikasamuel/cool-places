defmodule CoolPlacesWeb.DestinationsLive.Show do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Destinations

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(
        is_loading: false,
        travel_plan: nil,
        active_image_index: 0,
        active_destination_asset: nil
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    destination = Destinations.get_destination!(id)

    {:noreply,
     socket
     |> assign(:page_title, "Destination Details")
     |> assign(:destination, destination)
     |> assign(:active_destination_asset, destination.destination_asset |> Enum.at(0))}
  end

  @impl true
  def handle_event("generate_itinerary", _params, socket) do
    destination = socket.assigns.destination

    case CoolPlaces.Wrappers.Google.PlacesSearch.generate_itinerary(destination.name) do
      {:ok, itinerary} ->
        {:noreply,
         socket
         |> assign(:travel_plan, itinerary)}

      {:error, _reason} ->
        {:noreply,
         socket
         |> assign(:travel_plan, nil)}
    end
  end

  def handle_event("download_itinerary", _params, socket) do
    destination = socket.assigns.destination

    {:noreply,
     socket
     |> push_event("generate-pdf", %{
       elementId: "travel-itinerary-section",
       filename: "#{destination.name}-itinerary.pdf"
     })}
  end

  def handle_event("set_active_image", %{"active_image_index" => active_image_index}, socket) do
    active_image_index = String.to_integer(active_image_index)

    socket =
      socket
      |> set_active_image(active_image_index)

    {:noreply, socket}
  end

  def handle_event("prev_image", _params, socket) do
    active_image_index = Kernel.-(socket.assigns.active_image_index, 1)

    socket =
      socket
      |> set_active_image(active_image_index)

    {:noreply, socket}
  end

  def handle_event("next_image", _params, socket) do
    active_image_index = Kernel.+(socket.assigns.active_image_index, 1)

    socket =
      socket
      |> set_active_image(active_image_index)

    {:noreply, socket}
  end

  defp set_active_image(socket, index) do
    active_destination_asset = socket.assigns.destination.destination_asset

    if index < 0 or index >= length(active_destination_asset) do
      socket
    else
      socket
      |> assign(
        active_image_index: index,
        active_destination_asset: active_destination_asset |> Enum.at(index)
      )
    end
  end
end

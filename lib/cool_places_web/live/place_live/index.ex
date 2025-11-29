defmodule CoolPlacesWeb.PlaceLive.Index do
  use CoolPlacesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :destinations, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => _id}) do
    socket
    |> assign(:page_title, "Edit Place")

    # |> assign(:place, Places.get_place!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Place")

    # |> assign(:place, %Place{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Places")
    |> assign(:destination, nil)
  end

  @impl true
  def handle_info({CoolPlacesWeb.PlaceLive.FormComponent, {:saved, destination}}, socket) do
    {:noreply, stream_insert(socket, :destinations, destination)}
  end

  @impl true
  def handle_event("delete", %{"id" => _id}, socket) do
    # place = Places.get_place!(id)
    # {:ok, _} = Places.delete_place(place)
    # stream_delete(socket, :places, %{})
    {:noreply, socket}
  end
end

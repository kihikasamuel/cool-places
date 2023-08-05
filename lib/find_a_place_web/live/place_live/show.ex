defmodule FindAPlaceWeb.PlaceLive.Show do
  use FindAPlaceWeb, :live_view

  alias FindAPlace.Places

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:current_idx, 0)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:place, Places.get_place!(id))
    }
  end

  @impl true
  def handle_event("prev", %{}, socket) do
    assign_prev_idx(socket)
  end

  @impl true
  def handle_event("next", %{}, socket) do
    assign_next_idx(socket)
  end

  defp assign_prev_idx(socket) do
    current_index =
      socket.assigns.current_idx
      |> Kernel.-(1)
      |> rem(length(socket.assigns.place.images))

    {:noreply, socket |> assign(:current_idx, current_index)}
  end

  defp assign_next_idx(socket) do
    current_index =
      socket.assigns.current_idx
      |> Kernel.+(1)
      |> rem(length(socket.assigns.place.images))

    {:noreply, socket |> assign(:current_idx, current_index)}
  end

  defp set_default_image(list, current_idx) do
      list
      |> Enum.map(fn item -> item.url end)
      |> Enum.at(current_idx)
  end

  defp page_title(:show), do: "Show Place"
  defp page_title(:edit), do: "Edit Place"

end

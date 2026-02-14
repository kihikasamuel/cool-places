defmodule CoolPlacesWeb.VisitorLive.Map do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Visitors

  @impl true
  def mount(_params, _session, socket) do
    stats = Visitors.get_visitor_stats()

    {:ok,
     socket
     |> assign(:stats, stats)
     |> assign(:page_title, "Visitor World Map")}
  end

  @impl true
  def handle_event("get_markers", _params, socket) do
    markers = Visitors.get_map_data()
    {:reply, %{markers: markers}, socket}
  end
end

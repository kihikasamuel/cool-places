defmodule CoolPlacesWeb.DestinationsLive.New do
  use CoolPlacesWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-4 w-full max-w-2xl mx-auto">
      <h1>Listing</h1>
    </div>
    """
  end
end

defmodule CoolPlacesWeb.PageController do
  use CoolPlacesWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def coming_soon(conn, _params) do
    render(conn, :coming_soon, layout: false)
  end
end

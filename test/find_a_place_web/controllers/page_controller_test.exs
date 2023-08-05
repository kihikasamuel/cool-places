defmodule FindAPlaceWeb.PageControllerTest do
  use FindAPlaceWeb.ConnCase

  @moduletag :landing_page_setup

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Creator"
  end
end

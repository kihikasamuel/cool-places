defmodule CoolPlacesWeb.LegalLiveTest do
  use CoolPlacesWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders Privacy Policy page", %{conn: conn} do
    conn = get(conn, ~p"/privacy-policy")
    assert html_response(conn, 200) =~ "Privacy Policy"
    assert html_response(conn, 200) =~ "GDPR"
    assert html_response(conn, 200) =~ "CCPA"
  end

  test "renders Terms of Service page", %{conn: conn} do
    conn = get(conn, ~p"/terms-of-service")
    assert html_response(conn, 200) =~ "Terms of Service"
    assert html_response(conn, 200) =~ "Acceptance of Terms"
  end
end

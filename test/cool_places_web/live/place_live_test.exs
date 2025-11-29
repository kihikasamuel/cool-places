defmodule CoolPlacesWeb.PlaceLiveTest do
  use CoolPlacesWeb.ConnCase

  import Phoenix.LiveViewTest
  import CoolPlaces.PlacesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_place(_) do
    place = place_fixture()
    %{place: place}
  end

  describe "Index" do
    setup [:create_place]

    test "lists all places", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/places")

      assert html =~ "Listing Places"
    end

    test "saves new place", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/places")

      assert index_live |> element("a", "New Place") |> render_click() =~
               "New Place"

      assert_patch(index_live, ~p"/places/new")

      assert index_live
             |> form("#place-form", place: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#place-form", place: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/places")

      html = render(index_live)
      assert html =~ "Place created successfully"
    end

    test "updates place in listing", %{conn: conn, place: place} do
      {:ok, index_live, _html} = live(conn, ~p"/places")

      assert index_live |> element("#places-#{place.id} a", "Edit") |> render_click() =~
               "Edit Place"

      assert_patch(index_live, ~p"/places/#{place}/edit")

      assert index_live
             |> form("#place-form", place: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#place-form", place: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/places")

      html = render(index_live)
      assert html =~ "Place updated successfully"
    end

    test "deletes place in listing", %{conn: conn, place: place} do
      {:ok, index_live, _html} = live(conn, ~p"/places")

      assert index_live |> element("#places-#{place.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#places-#{place.id}")
    end
  end

  describe "Show" do
    setup [:create_place]

    test "displays place", %{conn: conn, place: place} do
      {:ok, _show_live, html} = live(conn, ~p"/places/#{place}")

      assert html =~ "Show Place"
    end

    test "updates place within modal", %{conn: conn, place: place} do
      {:ok, show_live, _html} = live(conn, ~p"/places/#{place}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Place"

      assert_patch(show_live, ~p"/places/#{place}/show/edit")

      assert show_live
             |> form("#place-form", place: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#place-form", place: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/places/#{place}")

      html = render(show_live)
      assert html =~ "Place updated successfully"
    end
  end
end

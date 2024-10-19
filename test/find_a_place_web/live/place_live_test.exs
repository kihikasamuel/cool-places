defmodule FindAPlaceWeb.PlaceLiveTest do
  use FindAPlaceWeb.ConnCase

  import Phoenix.LiveViewTest
  import FindAPlace.PlacesFixtures

  @create_attrs %{address: "some address", cost: "120.5", description: "some description", name: "some name"}
  @update_attrs %{address: "some updated address", cost: "456.7", description: "some updated description", name: "some updated name"}
  @invalid_attrs %{address: nil, cost: nil, description: nil, name: nil}

  defp create_place(_) do
    place = place_fixture()
    %{place: place}
  end

  describe "Index" do
    setup [:create_place]

    test "lists all places", %{conn: conn, places: places} do
      {:ok, _index_live, html} = live(conn, Routes.place_index_path(conn, :index))

      assert html =~ "Places"
      assert html =~ places
      # assert html_response(conn, 200) =~ "Places"
    end

    test "list all tags", %{conn: conn, place: place} do
      {:ok, _index_live, html} = live(conn, Routes.place_index_path(conn, :index))

      assert html =~ place
    end

    test "saves new place", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.place_index_path(conn, :index))

      assert index_live |> element("a", "+ List Places") |> render_click() =~
               "Add A Cool Place"

      assert_patch(index_live, Routes.place_index_path(conn, :new))

      assert index_live
             |> form("#place-form", place: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#place-form", place: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.place_index_path(conn, :index))

      assert html =~ "Place created successfully"
      assert html =~ "some address"
    end

    test "updates place in listing", %{conn: conn, place: place} do
      {:ok, index_live, _html} = live(conn, Routes.place_index_path(conn, :index))

      assert index_live |> element("#place-#{place.id} a", "Edit") |> render_click() =~
               "Edit This Cool Place"

      assert_patch(index_live, Routes.place_index_path(conn, :edit, place))

      assert index_live
             |> form("#place-form", place: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#place-form", place: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.place_index_path(conn, :index))

      assert html =~ "Place updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes place in listing", %{conn: conn, place: place} do
      {:ok, index_live, _html} = live(conn, Routes.place_index_path(conn, :index))

      assert index_live |> element("#place-#{place.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#place-#{place.id}")
    end
  end

  @tag :place_show_page
  describe "Show" do
    setup [:create_place]

    test "displays place", %{conn: conn, place: place} do
      {:ok, _show_live, html} = live(conn, Routes.place_show_path(conn, :show, place))

      assert html =~ "Show Place"
      assert html =~ place.address
    end

    test "updates place within modal", %{conn: conn, place: place} do
      {:ok, show_live, _html} = live(conn, Routes.place_show_path(conn, :show, place))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Place"

      assert_patch(show_live, Routes.place_show_path(conn, :edit, place))

      assert show_live
             |> form("#place-form", place: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#place-form", place: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.place_show_path(conn, :show, place))

      assert html =~ "Place updated successfully"
      assert html =~ "some updated address"
    end
  end
end

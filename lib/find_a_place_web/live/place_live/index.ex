defmodule FindAPlaceWeb.PlaceLive.Index do
  use FindAPlaceWeb, :live_view

  # import Logger
  alias FindAPlaceWeb.InitAssignsLive
  alias FindAPlace.Places
  alias FindAPlace.Places.Place

  on_mount {InitAssignsLive, :load_places}

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Places.subscribe()

    all_tags = Places.list_tags()

    {:ok,
      socket
      |> assign(:all_tags, all_tags)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit This Cool Place")
    |> assign(:place, Places.get_place!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Add A Cool Place")
    |> assign(:place, %Place{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Cool Places")
    |> assign(:places, socket.assigns.places)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    place = Places.get_place!(id)
    {:ok, _} = Places.delete_place(place)

    {:noreply, socket}
  end

  @impl true
  def handle_event("like_place", like_params, socket) do
    like(socket, like_params)
  end

  defp like(socket, params) do
    place_id = params["id"]
    new_params = Map.put(params, "place_id", place_id)

    case Places.create_like(new_params) do
      {:ok, _like} ->
        {:noreply,
          socket
          |> put_flash(:info, "You Upvoted this Place. Thank you <3!")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
        socket
        |> put_flash(:error, "Error occured while upvoting!")
        |> assign(:changeset, changeset)}
    end
  end

  @impl true
  def handle_info({:updates, place}, socket) do
    IO.inspect("SILENT")
    InitAssignsLive.on_inserted(place)
    IO.inspect("SILENT")
    {:noreply, socket}
    # {:noreply, update(socket, :places, fn places -> [place | places] end)}
  end

  # @impl true
  # def handle_info({:liked, like}, socket) do
  #   IO.inspect(like, label: "New Like")
  #   {:noreply, update(socket, :places, fn places -> )}
  # end

  def get_total_likes(params) do
    Enum.reduce(params.vote, 0, fn vote, acc ->
      vote
      |> Decimal.add(acc)
    end)
  end

end

defmodule FindAPlaceWeb.PlaceLive.FormComponent do
  use FindAPlaceWeb, :live_component

  alias FindAPlace.Places
  alias FindAPlace.Places.Tag

  @impl true
  def update(%{place: place} = assigns, socket) do
    changeset = Places.change_place(place)

    socket =
      socket
      |> assign(assigns)
      |> assign(:place_images, [])
      |> assign(:tags, MapSet.new())
      |> assign(:tags_in_tag, [])
      |> assign(:missing_tag_name, "")
      |> allow_upload(:image,
        accept: ~w(.jpg .jpeg .png),
        max_entries: 5,
        max_file_size: 2_000_000
      )
      |> assign(:changeset, changeset)

    {:ok, socket}
  end

  @impl true
  def handle_event("look-up", %{"place" => %{"tags" => tags_name}}, socket) do
    # search_term = tags;

    result = Places.search_tags_by(tags_name)
    IO.inspect(result)

    if(result === [], do:
      {:noreply, socket |> assign(:missing_tag_name, tags_name) |> assign(:tags_in_tag, [])},
    else:
      {:noreply, socket |> assign(:tags_in_tag, result) |> assign(:missing_tag_name, "")}
    )

  end

  @impl true
  def handle_event("select-tag", %{"id" => id}, socket) do
    tag = Places.get_tag!(id) |> Map.from_struct()

    updated_tags = MapSet.put(socket.assigns.tags, tag)

    {:noreply, socket |> assign(:tags, updated_tags) |> assign(:tags_in_tag, [])}
  end

  @impl true
  def handle_event("add-new-tags", tag_params, socket) do
    case Places.create_tag(tag_params) do
      {:ok, %Tag{} = new_tag} ->

        tag = new_tag |> Map.from_struct()
        updated_tags = MapSet.put(socket.assigns.tags, tag)

        {:noreply, socket |> assign(:tags, updated_tags) |> assign(:missing_tag_name, "")}

      {:error, %Ecto.Changeset{} = _changeset} ->
        {:noreply, socket |> assign(:missing_tag_name, tag_params["name"])}
    end
  end

  @impl true
  def handle_event("validate", %{"place" => place_params}, socket) do
    changeset =
      socket.assigns.place
      |> Places.change_place(place_params)
      |> Map.put("tags", socket.assigns.tags |> MapSet.to_list())
      |> Map.put(:action, :validate)
      |> IO.inspect(label: "ON Validation: ")

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  def handle_event("save", %{"place" => params}, socket) do
    place_images =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest =Path.join([:code.priv_dir(:find_a_place),"static","uploads",Path.basename(path)])

        File.cp!(path, dest)
        {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
      end)

    mapped_images =
      place_images
      |> Enum.map(fn image_url -> %{url: image_url, alt: params["name"]} end)

    mapped_tags =
      socket.assigns.tags
      |> MapSet.to_list()
      |> Enum.map(fn tag -> %{id: tag.id, name: tag.name, inserted_at: tag.inserted_at, updated_at: tag.updated_at} end)

    place_params =
      params
      |> Map.put("images", mapped_images)
      |> Map.put("tags", mapped_tags)

    save_place(socket, socket.assigns.action, place_params)
  end

  defp save_place(socket, :edit, place_params) do
    case Places.update_place(socket.assigns.place, place_params) do
      {:ok, _place} ->
        {:noreply,
         socket
         |> put_flash(:info, "Place updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_place(socket, :new, place_params) do
    IO.inspect(place_params, label: "PLACE PARAMS WHEN SAVING: ")
    case Places.create_place(place_params) do
      {:ok, _place} ->
        {:noreply,
         socket
         |> put_flash(:info, "Place created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset, label: "Error Occurs due to: ")
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end

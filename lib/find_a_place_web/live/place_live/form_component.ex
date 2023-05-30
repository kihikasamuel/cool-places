defmodule FindAPlaceWeb.PlaceLive.FormComponent do
  use FindAPlaceWeb, :live_component

  alias FindAPlace.Places

  @impl true
  def update(%{place: place} = assigns, socket) do
    changeset = Places.change_place(place)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:place_images, [])
     |> allow_upload(:image,
      accept: ~w(.jpg .jpeg .png),
      max_entries: 5,
      max_file_size: 2_000_000
     )
     |> assign(:changeset, changeset)
    }
  end

  @impl true
  def handle_event("validate", %{"place" => place_params}, socket) do
    changeset =
      socket.assigns.place
      |> Places.change_place(place_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("cancel-upload", %{"ref" => ref, "value" => val}, socket) do
    IO.inspect(val)
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  def handle_event("save", %{"place" => place_params}, socket) do
    place_images =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest =Path.join([:code.priv_dir(:nextshop),"static","uploads",Path.basename(path)])

        File.cp!(path, dest)
        {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
      end)

    place_params =
      place_params
      |> Map.put(:images, place_images)

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
    case Places.create_place(place_params) do
      {:ok, _place} ->
        {:noreply,
         socket
         |> put_flash(:info, "Place created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end

defmodule CoolPlacesWeb.DestinationsLive.New do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Destinations.Destination
  alias CoolPlaces.Destinations
  alias CoolPlaces.Utils.Uploads
  alias CoolPlaces.Wrappers.Google.PlacesSearch

  def mount(_params, _session, socket) do
    changeset = Destination.changeset(%Destination{}, %{"destination_assets" => []})
    countries = CoolPlaces.Countries.list_countries() |> Enum.map(&{&1.name, &1.id})

    socket =
      socket
      |> assign(
        page_title: "List Your Discovery",
        countries: countries,
        uploaded_files: [],
        destination_search_results: [],
        selected_address: nil,
        selected_country_id: nil
      )
      |> assign_form(changeset)
      |> allow_upload(:destination_asset,
        accept: ~w(.jpg .jpeg .png),
        max_entries: 5,
        max_file_size: 1_000_000,
        auto_upload: true
      )

    {:ok, socket}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("search_destination", %{"value" => search_value}, socket) do
    {:ok, results} = PlacesSearch.search(search_value)

    {:noreply, socket |> assign(destination_search_results: results, selected_address: nil)}
  end

  def handle_event("select_address", %{"addressvalue" => address_id}, socket) do
    address = Enum.find(socket.assigns.destination_search_results, &(&1["id"] == address_id))
    selected_country = Enum.find(socket.assigns.countries, &(&1 |> elem(0) == address["country"]))
    selected_country_id = selected_country |> elem(1)

    selected_address = %{
      "id" => address["id"],
      "name" => address["name"],
      "street" => address["address"],
      "city" => address["city"],
      "town" => address["town"],
      "postal_code" => address["postal_code"],
      "coordinates" => %{
        "lat" => address["lat"],
        "lng" => address["lng"]
      }
    }

    {:noreply,
     socket
     |> assign(selected_address: selected_address, selected_country_id: selected_country_id)}
  end

  def handle_event("clear_search", _, socket) do
    {:noreply, socket |> assign(destination_search_results: [], selected_address: nil)}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :destination_asset, ref)}
  end

  def handle_event("publish", params, socket) do
    uploaded_file =
      consume_uploaded_entries(socket, :destination_asset, fn %{path: path}, entry ->
        tmp_file = File.read!(path)
        file_name = Path.basename(path) <> ".#{ext(entry)}"

        with {:ok, file_path} <- Uploads.store(%{filename: file_name, binary: tmp_file}) do
          {:ok, Uploads.url(file_path)}
        else
          _ ->
            {:ok, "/uploads/destinations/#{file_name}"}
        end
      end)

    socket =
      socket
      |> update(:uploaded_files, &(&1 ++ uploaded_file))

    mapped_files =
      socket.assigns.uploaded_files
      |> parse_uploads()

    params =
      params
      |> Map.put("destination_asset", mapped_files)
      |> Map.put("user_id", socket.assigns.current_user.id)
      |> Map.put("address", socket.assigns.selected_address)
      |> Map.put("country_id", socket.assigns.selected_country_id)

    publish_destination(socket, socket.assigns.live_action, params)
  end

  defp publish_destination(socket, :new, destination_params) do
    case Destinations.create_destination(destination_params) do
      {:ok, _destination} ->
        {:noreply,
         socket
         |> put_flash(:info, "Your discovery has been published")
         |> redirect(to: ~p(/account/listing))}

      {:error, %Ecto.Changeset{} = _changeset} ->
        {
          :noreply,
          socket
          |> put_flash(:error, "Error while publishing your discovery. Kindly, check the form!")
          #  |> assign_form(changeset)
        }
    end
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"

  ## get file extension
  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    ext
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset)

    if changeset.valid? do
      assign(socket, form: form, check_errors: true)
    else
      assign(socket, form: form)
    end
  end

  defp parse_uploads(uploads) do
    uploads
    |> Enum.map(fn file_uploaded ->
      %{
        "asset_url" => file_uploaded
      }
    end)
    |> Enum.with_index()
    |> Map.new(fn {value, index} -> {index, value} end)
  end
end

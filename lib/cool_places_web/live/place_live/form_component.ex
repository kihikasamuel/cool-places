defmodule CoolPlacesWeb.PlaceLive.FormComponent do
  use CoolPlacesWeb, :live_component

  # alias CoolPlaces.Places

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #   <div>
  #     <.header>
  #       {@title}
  #       <:subtitle>Use this form to manage place records in your database.</:subtitle>
  #     </.header>

  #     <.simple_form
  #       for={@form}
  #       id="place-form"
  #       phx-target={@myself}
  #       phx-change="validate"
  #       phx-submit="save"
  #     >

  #       <:actions>
  #         <.button phx-disable-with="Saving...">Save Place</.button>
  #       </:actions>
  #     </.simple_form>
  #   </div>
  #   """
  # end

  # @impl true
  # def update(%{place: place} = assigns, socket) do
  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #    |> assign_new(:form, fn ->
  #      to_form(Places.change_place(place))
  #    end)}
  # end

  # @impl true
  # def handle_event("validate", %{"place" => place_params}, socket) do
  #   changeset = Places.change_place(socket.assigns.place, place_params)
  #   {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  # end

  # def handle_event("save", %{"place" => place_params}, socket) do
  #   save_place(socket, socket.assigns.action, place_params)
  # end

  # defp save_place(socket, :edit, place_params) do
  #   case Places.update_place(socket.assigns.place, place_params) do
  #     {:ok, place} ->
  #       notify_parent({:saved, place})

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Place updated successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, form: to_form(changeset))}
  #   end
  # end

  # defp save_place(socket, :new, place_params) do
  #   case Places.create_place(place_params) do
  #     {:ok, place} ->
  #       notify_parent({:saved, place})

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Place created successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, form: to_form(changeset))}
  #   end
  # end

  # defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

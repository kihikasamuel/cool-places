defmodule CoolPlacesWeb.UserRegistrationLive.Index do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Accounts
  alias CoolPlaces.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})
    countries = CoolPlaces.Countries.list_countries() |> Enum.map(&{&1.name, &1.id})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false, countries: countries)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)

        {:noreply,
         socket
         |> assign_form(changeset)
         |> put_flash(
           :info,
           "Registration successful. Please check your email to confirm your account."
         )
         |> push_navigate(to: ~p(/users/log_in))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      Accounts.change_user_registration(%User{}, user_params) |> IO.inspect(label: "changeset")

    {:noreply, assign_form(socket, changeset)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset)

    if changeset.valid? do
      assign(socket, form: form, check_errors: true)
    else
      assign(socket, form: form)
    end
  end
end

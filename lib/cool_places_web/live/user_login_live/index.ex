defmodule CoolPlacesWeb.UserLoginLive.Index do
  use CoolPlacesWeb, :live_view
  alias CoolPlaces.Accounts

  def mount(_params, _session, socket) do
    # email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = Accounts.validate_user_login(%{}) |> to_form()
    {:ok, assign(socket, form: form, trigger_submit: false), temporary_assigns: [form: form]}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", params, socket) do
    changeset =
      params
      |> Accounts.validate_user_login()
      |> to_form()

    {:noreply, socket |> assign(form: changeset)}
  end

  def handle_event("login", _params, socket) do
    {:noreply,
     socket
     |> assign(trigger_submit: true)}
  end
end

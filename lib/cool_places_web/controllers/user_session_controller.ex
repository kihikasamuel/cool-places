defmodule CoolPlacesWeb.UserSessionController do
  use CoolPlacesWeb, :controller

  alias CoolPlaces.Accounts
  alias CoolPlaces.Accounts.User
  alias CoolPlacesWeb.UserAuth

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Account created successfully!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/users/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    create(conn, params, "Welcome back!")
  end

  defp create(conn, user_params, info) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/users/log_in")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

  def request(conn, _params) do
    conn
    |> put_flash(:info, "Redirecting...")
    |> redirect(to: ~p(/users/log_in), callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _failure_reason}} = conn, _params) do
    conn
    |> put_flash(:error, "Authentication failed, please try again.")
    |> redirect(to: ~p(/users/log_in))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    with %Ueberauth.Auth{} <- auth,
         {:ok, %User{} = user} <- Accounts.find_or_register_user(auth) do
      conn
      |> put_flash(:info, "Welcome back")
      |> UserAuth.log_in_user(user, %{"email" => user.email})
    else
      _ ->
        conn
        |> put_flash(:error, "Authentication failed, please try again.")
        |> redirect(to: ~p(/users/log_in))
    end
  end
end

defmodule CoolPlaces.Accounts.UserNotifier do
  import Swoosh.Email

  alias CoolPlaces.Mailer
  alias CoolPlacesWeb.EmailLayouts

  # Delivers the email using the application mailer.
  def deliver(recipient, subject, text_body, html_body) do
    email =
      new()
      |> to(recipient)
      |> from({"CoolPlaces", "hello@coolplaces.co.ke"})
      |> subject(subject)
      |> text_body(text_body)
      |> html_body(html_body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    text_body = """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """

    html_body = EmailLayouts.render("email_confirmation.html", url: url, user: user)

    deliver(user.email, "Confirmation instructions", text_body, html_body)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    text_body = """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """

    html_body = EmailLayouts.render("email_reset_password.html", url: url, user: user)

    deliver(user.email, "Reset password instructions", text_body, html_body)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    text_body = """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """

    html_body = EmailLayouts.render("email_update_email.html", url: url, user: user)

    deliver(user.email, "Update email instructions", text_body, html_body)
  end
end

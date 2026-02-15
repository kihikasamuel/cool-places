defmodule CoolPlaces.Newsletters do
  @moduledoc """
  The Newsletters context.
  """

  import Ecto.Query, warn: false
  alias CoolPlaces.Repo

  alias CoolPlaces.Newsletters.Newsletter

  @doc """
  Returns the list of newsletters.

  ## Examples

      iex> list_newsletters()
      [%Newsletter{}, ...]

  """
  def list_newsletters do
    Repo.all(Newsletter)
  end

  @doc """
  Gets a single newsletter.

  Raises `Ecto.NoResultsError` if the Newsletter does not exist.

  ## Examples

      iex> get_newsletter!(123)
      %Newsletter{}

      iex> get_newsletter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_newsletter!(id), do: Repo.get!(Newsletter, id)

  @doc """
  Creates a newsletter.

  ## Examples

      iex> create_newsletter(%{field: value})
      {:ok, %Newsletter{}}

      iex> create_newsletter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_newsletter(attrs \\ %{}) do
    %Newsletter{}
    |> Newsletter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a newsletter.

  ## Examples

      iex> update_newsletter(newsletter, %{field: new_value})
      {:ok, %Newsletter{}}

      iex> update_newsletter(newsletter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_newsletter(%Newsletter{} = newsletter, attrs) do
    newsletter
    |> Newsletter.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a newsletter.

  ## Examples

      iex> delete_newsletter(newsletter)
      {:ok, %Newsletter{}}

      iex> delete_newsletter(newsletter)
      {:error, %Ecto.Changeset{}}

  """
  def delete_newsletter(%Newsletter{} = newsletter) do
    Repo.delete(newsletter)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking newsletter changes.

  ## Examples

      iex> change_newsletter(newsletter)
      %Ecto.Changeset{data: %Newsletter{}}

  """
  def change_newsletter(%Newsletter{} = newsletter, attrs \\ %{}) do
    Newsletter.changeset(newsletter, attrs)
  end

  alias CoolPlaces.Newsletters.Subscription

  @doc """
  Returns the list of subscription.

  ## Examples

      iex> list_subscription()
      [%Subscription{}, ...]

  """
  def list_subscription do
    Repo.all(Subscription)
  end

  @doc """
  Gets a single subscription.

  Raises `Ecto.NoResultsError` if the Subscription does not exist.

  ## Examples

      iex> get_subscription!(123)
      %Subscription{}

      iex> get_subscription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscription!(id), do: Repo.get!(Subscription, id)

  @doc """
  Creates a subscription.

  ## Examples

      iex> subscribe(%{field: value})
      {:ok, %Subscription{}}

      iex> subscribe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def subscribe(attrs \\ %{}) do
    %Subscription{}
    |> Subscription.changeset(attrs)
    |> IO.inspect(label: "Subscription Changeset")
    |> Repo.insert()
  end

  @doc """
  Updates a subscription.

  ## Examples

      iex> update_subscription(subscription, %{field: new_value})
      {:ok, %Subscription{}}

      iex> update_subscription(subscription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscription(%Subscription{} = subscription, attrs) do
    subscription
    |> Subscription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subscription.

  ## Examples

      iex> delete_subscription(subscription)
      {:ok, %Subscription{}}

      iex> delete_subscription(subscription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscription(%Subscription{} = subscription) do
    Repo.delete(subscription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subscription changes.

  ## Examples

      iex> change_subscription(subscription)
      %Ecto.Changeset{data: %Subscription{}}

  """
  def change_subscription(%Subscription{} = subscription, attrs \\ %{}) do
    Subscription.changeset(subscription, attrs)
  end

  def maybe_send_subscription_email(subscription) do
    text_body = "Congratulations! You have been added to our waitlist. We'll keep you posted!"
    html_body = CoolPlacesWeb.EmailLayouts.render("email_newsletter_confirmation.html", %{})

    CoolPlaces.Accounts.UserNotifier.deliver(
      subscription.email,
      "Subscription Confirmed",
      text_body,
      html_body
    )
  end
end

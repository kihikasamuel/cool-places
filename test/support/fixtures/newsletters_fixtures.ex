defmodule CoolPlaces.NewslettersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CoolPlaces.Newsletters` context.
  """

  @doc """
  Generate a newsletter.
  """
  def newsletter_fixture(attrs \\ %{}) do
    {:ok, newsletter} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Newsletters.create_newsletter()

    newsletter
  end

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Newsletters.create_subscription()

    subscription
  end
end

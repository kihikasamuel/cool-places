defmodule CoolPlaces.RatingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CoolPlaces.Ratings` context.
  """

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Ratings.create_rating()

    rating
  end
end

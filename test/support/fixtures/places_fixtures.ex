defmodule FindAPlace.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FindAPlace.Places` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    {:ok, place} =
      attrs
      |> Enum.into(%{
        address: "some address",
        cost: "120.5",
        description: "some description",
        name: "some name"
      })
      |> FindAPlace.Places.create_place()

    place
  end

  @doc """
  Generate a like.
  """
  def like_fixture(attrs \\ %{}) do
    {:ok, like} =
      attrs
      |> Enum.into(%{
        vote: 42
      })
      |> FindAPlace.Places.create_like()

    like
  end

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> FindAPlace.Places.create_tag()

    tag
  end
end

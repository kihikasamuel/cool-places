defmodule CoolPlaces.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CoolPlaces.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Users.create_user()

    user
  end
end

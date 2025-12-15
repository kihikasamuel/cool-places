defmodule CoolPlaces.DestinationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CoolPlaces.Destinations` context.
  """

  @doc """
  Generate a destination.
  """
  def destination_fixture(attrs \\ %{}) do
    {:ok, destination} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Destinations.create_destination()

    destination
  end
end

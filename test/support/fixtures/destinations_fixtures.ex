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

  @doc """
  Generate a destination_asset.
  """
  def destination_asset_fixture(attrs \\ %{}) do
    {:ok, destination_asset} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Destinations.create_destination_asset()

    destination_asset
  end

  @doc """
  Generate a destination_asset_mapping.
  """
  def destination_asset_mapping_fixture(attrs \\ %{}) do
    {:ok, destination_asset_mapping} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Destinations.create_destination_asset_mapping()

    destination_asset_mapping
  end
end

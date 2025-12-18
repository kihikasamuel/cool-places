defmodule CoolPlaces.CountriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CoolPlaces.Countries` context.
  """

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Countries.create_country()

    country
  end
end

defmodule CoolPlaces.CoutriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CoolPlaces.Coutries` context.
  """

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{})
      |> CoolPlaces.Coutries.create_country()

    country
  end
end

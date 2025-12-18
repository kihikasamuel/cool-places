defmodule CoolPlaces.CountriesTest do
  use CoolPlaces.DataCase

  alias CoolPlaces.Countries

  describe "countries" do
    alias CoolPlaces.Countries.Country

    import CoolPlaces.CountriesFixtures

    @invalid_attrs %{}

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Countries.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Countries.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      valid_attrs = %{}

      assert {:ok, %Country{} = country} = Countries.create_country(valid_attrs)
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Countries.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      update_attrs = %{}

      assert {:ok, %Country{} = country} = Countries.update_country(country, update_attrs)
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Countries.update_country(country, @invalid_attrs)
      assert country == Contries.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Countries.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Countries.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Countries.change_country(country)
    end
  end
end

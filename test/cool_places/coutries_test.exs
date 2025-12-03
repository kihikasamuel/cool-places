defmodule CoolPlaces.CoutriesTest do
  use CoolPlaces.DataCase

  alias CoolPlaces.Coutries

  describe "countries" do
    alias CoolPlaces.Coutries.Country

    import CoolPlaces.CoutriesFixtures

    @invalid_attrs %{}

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Coutries.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Coutries.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      valid_attrs = %{}

      assert {:ok, %Country{} = country} = Coutries.create_country(valid_attrs)
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Coutries.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      update_attrs = %{}

      assert {:ok, %Country{} = country} = Coutries.update_country(country, update_attrs)
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Coutries.update_country(country, @invalid_attrs)
      assert country == Coutries.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Coutries.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Coutries.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Coutries.change_country(country)
    end
  end
end

defmodule CoolPlaces.DestinationsTest do
  use CoolPlaces.DataCase

  alias CoolPlaces.Destinations

  describe "destinations" do
    alias CoolPlaces.Destinations.Destination

    import CoolPlaces.DestinationsFixtures

    @invalid_attrs %{}

    test "list_destinations/0 returns all destinations" do
      destination = destination_fixture()
      assert Destinations.list_destinations() == [destination]
    end

    test "get_destination!/1 returns the destination with given id" do
      destination = destination_fixture()
      assert Destinations.get_destination!(destination.id) == destination
    end

    test "create_destination/1 with valid data creates a destination" do
      valid_attrs = %{}

      assert {:ok, %Destination{} = destination} = Destinations.create_destination(valid_attrs)
    end

    test "create_destination/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Destinations.create_destination(@invalid_attrs)
    end

    test "update_destination/2 with valid data updates the destination" do
      destination = destination_fixture()
      update_attrs = %{}

      assert {:ok, %Destination{} = destination} =
               Destinations.update_destination(destination, update_attrs)
    end

    test "update_destination/2 with invalid data returns error changeset" do
      destination = destination_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Destinations.update_destination(destination, @invalid_attrs)

      assert destination == Destinations.get_destination!(destination.id)
    end

    test "delete_destination/1 deletes the destination" do
      destination = destination_fixture()
      assert {:ok, %Destination{}} = Destinations.delete_destination(destination)
      assert_raise Ecto.NoResultsError, fn -> Destinations.get_destination!(destination.id) end
    end

    test "change_destination/1 returns a destination changeset" do
      destination = destination_fixture()
      assert %Ecto.Changeset{} = Destinations.change_destination(destination)
    end
  end

  describe "destination_assets" do
    alias CoolPlaces.Destinations.DestinationAsset

    import CoolPlaces.DestinationsFixtures

    @invalid_attrs %{}

    test "list_destination_assets/0 returns all destination_assets" do
      destination_asset = destination_asset_fixture()
      assert Destinations.list_destination_assets() == [destination_asset]
    end

    test "get_destination_asset!/1 returns the destination_asset with given id" do
      destination_asset = destination_asset_fixture()
      assert Destinations.get_destination_asset!(destination_asset.id) == destination_asset
    end

    test "create_destination_asset/1 with valid data creates a destination_asset" do
      valid_attrs = %{}

      assert {:ok, %DestinationAsset{} = destination_asset} =
               Destinations.create_destination_asset(valid_attrs)
    end

    test "create_destination_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Destinations.create_destination_asset(@invalid_attrs)
    end

    test "update_destination_asset/2 with valid data updates the destination_asset" do
      destination_asset = destination_asset_fixture()
      update_attrs = %{}

      assert {:ok, %DestinationAsset{} = destination_asset} =
               Destinations.update_destination_asset(destination_asset, update_attrs)
    end

    test "update_destination_asset/2 with invalid data returns error changeset" do
      destination_asset = destination_asset_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Destinations.update_destination_asset(destination_asset, @invalid_attrs)

      assert destination_asset == Destinations.get_destination_asset!(destination_asset.id)
    end

    test "delete_destination_asset/1 deletes the destination_asset" do
      destination_asset = destination_asset_fixture()
      assert {:ok, %DestinationAsset{}} = Destinations.delete_destination_asset(destination_asset)

      assert_raise Ecto.NoResultsError, fn ->
        Destinations.get_destination_asset!(destination_asset.id)
      end
    end

    test "change_destination_asset/1 returns a destination_asset changeset" do
      destination_asset = destination_asset_fixture()
      assert %Ecto.Changeset{} = Destinations.change_destination_asset(destination_asset)
    end
  end

  describe "destination_asset_mapping" do
    alias CoolPlaces.Destinations.DestinationAssetMapping

    import CoolPlaces.DestinationsFixtures

    @invalid_attrs %{}

    test "list_destination_asset_mapping/0 returns all destination_asset_mapping" do
      destination_asset_mapping = destination_asset_mapping_fixture()
      assert Destinations.list_destination_asset_mapping() == [destination_asset_mapping]
    end

    test "get_destination_asset_mapping!/1 returns the destination_asset_mapping with given id" do
      destination_asset_mapping = destination_asset_mapping_fixture()

      assert Destinations.get_destination_asset_mapping!(destination_asset_mapping.id) ==
               destination_asset_mapping
    end

    test "create_destination_asset_mapping/1 with valid data creates a destination_asset_mapping" do
      valid_attrs = %{}

      assert {:ok, %DestinationAssetMapping{} = destination_asset_mapping} =
               Destinations.create_destination_asset_mapping(valid_attrs)
    end

    test "create_destination_asset_mapping/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Destinations.create_destination_asset_mapping(@invalid_attrs)
    end

    test "update_destination_asset_mapping/2 with valid data updates the destination_asset_mapping" do
      destination_asset_mapping = destination_asset_mapping_fixture()
      update_attrs = %{}

      assert {:ok, %DestinationAssetMapping{} = destination_asset_mapping} =
               Destinations.update_destination_asset_mapping(
                 destination_asset_mapping,
                 update_attrs
               )
    end

    test "update_destination_asset_mapping/2 with invalid data returns error changeset" do
      destination_asset_mapping = destination_asset_mapping_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Destinations.update_destination_asset_mapping(
                 destination_asset_mapping,
                 @invalid_attrs
               )

      assert destination_asset_mapping ==
               Destinations.get_destination_asset_mapping!(destination_asset_mapping.id)
    end

    test "delete_destination_asset_mapping/1 deletes the destination_asset_mapping" do
      destination_asset_mapping = destination_asset_mapping_fixture()

      assert {:ok, %DestinationAssetMapping{}} =
               Destinations.delete_destination_asset_mapping(destination_asset_mapping)

      assert_raise Ecto.NoResultsError, fn ->
        Destinations.get_destination_asset_mapping!(destination_asset_mapping.id)
      end
    end

    test "change_destination_asset_mapping/1 returns a destination_asset_mapping changeset" do
      destination_asset_mapping = destination_asset_mapping_fixture()

      assert %Ecto.Changeset{} =
               Destinations.change_destination_asset_mapping(destination_asset_mapping)
    end
  end
end

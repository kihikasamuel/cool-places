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
end

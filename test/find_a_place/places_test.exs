defmodule FindAPlace.PlacesTest do
  use FindAPlace.DataCase

  alias FindAPlace.Places

  describe "places" do
    alias FindAPlace.Places.Place

    import FindAPlace.PlacesFixtures

    @invalid_attrs %{address: nil, cost: nil, description: nil, name: nil}

    test "list_places/0 returns all places" do
      place = place_fixture()
      assert Places.list_places() == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Places.get_place!(place.id) == place
    end

    test "create_place/1 with valid data creates a place" do
      valid_attrs = %{address: "some address", cost: "120.5", description: "some description", name: "some name"}

      assert {:ok, %Place{} = place} = Places.create_place(valid_attrs)
      assert place.address == "some address"
      assert place.cost == Decimal.new("120.5")
      assert place.description == "some description"
      assert place.name == "some name"
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Places.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()
      update_attrs = %{address: "some updated address", cost: "456.7", description: "some updated description", name: "some updated name"}

      assert {:ok, %Place{} = place} = Places.update_place(place, update_attrs)
      assert place.address == "some updated address"
      assert place.cost == Decimal.new("456.7")
      assert place.description == "some updated description"
      assert place.name == "some updated name"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Places.update_place(place, @invalid_attrs)
      assert place == Places.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Places.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Places.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Places.change_place(place)
    end
  end

  describe "likes" do
    alias FindAPlace.Places.Like

    import FindAPlace.PlacesFixtures

    @invalid_attrs %{vote: nil}

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Places.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Places.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      valid_attrs = %{vote: 42}

      assert {:ok, %Like{} = like} = Places.create_like(valid_attrs)
      assert like.vote == 42
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Places.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      update_attrs = %{vote: 43}

      assert {:ok, %Like{} = like} = Places.update_like(like, update_attrs)
      assert like.vote == 43
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Places.update_like(like, @invalid_attrs)
      assert like == Places.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Places.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Places.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Places.change_like(like)
    end
  end

  describe "tags" do
    alias FindAPlace.Places.Tag

    import FindAPlace.PlacesFixtures

    @invalid_attrs %{name: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Places.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Places.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Tag{} = tag} = Places.create_tag(valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Places.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Tag{} = tag} = Places.update_tag(tag, update_attrs)
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Places.update_tag(tag, @invalid_attrs)
      assert tag == Places.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Places.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Places.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Places.change_tag(tag)
    end
  end
end

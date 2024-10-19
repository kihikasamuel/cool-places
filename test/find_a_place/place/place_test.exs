defmodule FindAPlace.Place.PlaceTest do
  use FindAPlace.DataCase, async: true

  alias FindAPlace.Places.Place

  test "name should be at least 2 character(s)" do
    changeset = Place.changeset(%Place{}, %{name: "K", address: "Hello", cost: 100, description: "A sample place"})
    assert %{name: ["should be at least 2 character(s)"]} = errors_on(changeset)
  end

  test "address cannot be blank" do
    changeset = Place.changeset(%Place{}, %{name: "K", cost: 100, description: "A sample place"})
    assert %{address: ["can't be blank"]} = errors_on(changeset)
  end
end

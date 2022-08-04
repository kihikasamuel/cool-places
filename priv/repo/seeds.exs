# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FindAPlace.Repo.insert!(%FindAPlace.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _} = FindAPlace.Places.create_like(%{vote: 1, place_id: "b90d1e1b-ab28-4ff5-bd80-db17fd74fa03"})

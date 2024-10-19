defmodule FindAPlace.Places do
  @moduledoc """
  The Places context.
  """

  import Ecto.Query, warn: false
  alias FindAPlace.Repo

  alias FindAPlace.Places.Place

  @doc """
  Returns the list of places.

  ## Examples

      iex> list_places()
      [%Place{}, ...]

  """
  def list_places do
    query = from p in Place, order_by: [desc: p.inserted_at]
    Repo.all(query)
    |> Repo.preload([:likes, :images, places_tags: [:tag]])
  end

  @doc """
  Gets a single place.

  Raises `Ecto.NoResultsError` if the Place does not exist.

  ## Examples

      iex> get_place!(123)
      %Place{}

      iex> get_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_place!(id), do: Repo.get!(Place, id)|> Repo.preload([:likes, :images, places_tags: [:tag]])

  @doc """
  Creates a place.

  ## Examples

      iex> create_place(%{field: value})
      {:ok, %Place{}}

      iex> create_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_place(attrs \\ %{}) do

    # images = Enum.map(attrs["images"], fn image -> %{url: image.url, alt: image.alt} end)

    # tags = Enum.map(attrs["tags"], fn tag -> %{name: tag.name, id: tag.id, inserted_at: tag.inserted_at, updated_at: tag.updated_at} end)
    places_tags = Enum.map(attrs["tags"], fn tag -> %{tag_id: tag.id} end)

    place = Place.changeset(%Place{}, %{
      name: attrs["name"],
      address: attrs["address"],
      description: attrs["description"],
      cost: attrs["cost"] |> Decimal.new(),
      images: attrs["images"],
      places_tags: places_tags
    })

    result = Ecto.Multi.new()
    |> Ecto.Multi.insert(:insert, place)
    |> Repo.transaction()
    |> case do
      {:ok, place} -> {:ok, place}
      {:error, name, value, _changes_so_far} -> {:error, {name, value}}
    end

    broadcast(result, :updates)
  end

  @doc """
  Updates a place.

  ## Examples

      iex> update_place(place, %{field: new_value})
      {:ok, %Place{}}

      iex> update_place(place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_place(%Place{} = place, attrs) do
    place
    |> Place.changeset(attrs)
    |> Repo.update()
    |> broadcast(:updates)
  end

  @doc """
  Deletes a place.

  ## Examples

      iex> delete_place(place)
      {:ok, %Place{}}

      iex> delete_place(place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking place changes.

  ## Examples

      iex> change_place(place)
      %Ecto.Changeset{data: %Place{}}

  """
  def change_place(%Place{} = place, attrs \\ %{}) do
    Place.changeset(place, attrs)
  end

  #
  def subscribe do
    Phoenix.PubSub.subscribe(FindAPlace.PubSub, "updates")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, place}, _event) do
    Phoenix.PubSub.broadcast(FindAPlace.PubSub, "updates", place)
    {:ok, place}
  end

  alias FindAPlace.Places.Like

  @doc """
  Returns the list of likes.

  ## Examples

      iex> list_likes()
      [%Like{}, ...]

  """
  def list_likes do
    Repo.all(Like)|> Repo.preload([:place])
  end

  @doc """
  Gets a single like.

  Raises `Ecto.NoResultsError` if the Like does not exist.

  ## Examples

      iex> get_like!(123)
      %Like{}

      iex> get_like!(456)
      ** (Ecto.NoResultsError)

  """
  def get_like!(id), do: Repo.get!(Like, id)

  @doc """
  Creates a like.

  ## Examples

      iex> create_like(%{field: value})
      {:ok, %Like{}}

      iex> create_like(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_like(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:updates)
  end

  @doc """
  Updates a like.

  ## Examples

      iex> update_like(like, %{field: new_value})
      {:ok, %Like{}}

      iex> update_like(like, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_like(%Like{} = like, attrs) do
    like
    |> Like.changeset(attrs)
    |> Repo.update()
    |> broadcast(:updates)
  end

  @doc """
  Deletes a like.

  ## Examples

      iex> delete_like(like)
      {:ok, %Like{}}

      iex> delete_like(like)
      {:error, %Ecto.Changeset{}}

  """
  def delete_like(%Like{} = like) do
    Repo.delete(like)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking like changes.

  ## Examples

      iex> change_like(like)
      %Ecto.Changeset{data: %Like{}}

  """
  def change_like(%Like{} = like, attrs \\ %{}) do
    Like.changeset(like, attrs)
  end

  # def get_total_likes(%Like{} = like) do
  #   Enum.reduce(like.vote, 0, fn like, acc ->
  #     like
  #     |> Decimal.add(acc)
  #   end)
  # end

  alias FindAPlace.Places.Tag
  alias FindAPlace.Places.PlacesTags

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @spec get_tag_by(any) :: any
  def get_tag_by(name) do
    Repo.get_by(Tag, name: name)
  end


  def search_tags_by(search_term) do
    query = from t in Tag, where: ilike(t.name, ^"%#{search_term}%")
    Repo.all(query)
  end
  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end
  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end
end

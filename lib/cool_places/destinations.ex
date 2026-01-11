defmodule CoolPlaces.Destinations do
  @moduledoc """
  The Destinations context.
  """

  import Ecto.Query, warn: false
  alias CoolPlaces.Repo

  alias CoolPlaces.Destinations.Destination

  @doc """
  Returns the list of destinations.

  ## Examples

      iex> list_destinations()
      [%Destination{}, ...]

  """
  def list_destinations(queryable \\ Destination, opts \\ [page: 1, per_page: 20]) do
    queryable
    |> preload_assoc_query()
    |> Repo.paginate(opts)
  end

  @doc """
  Gets a single destination.

  Raises `Ecto.NoResultsError` if the Destination does not exist.

  ## Examples

      iex> get_destination!(123)
      %Destination{}

      iex> get_destination!(456)
      ** (Ecto.NoResultsError)

  """
  def get_destination!(id), do: Repo.get!(Destination, id)

  @doc """
  Creates a destination.

  ## Examples

      iex> create_destination(%{field: value})
      {:ok, %Destination{}}

      iex> create_destination(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_destination(attrs \\ %{}) do
    %Destination{}
    |> Destination.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a destination.

  ## Examples

      iex> update_destination(destination, %{field: new_value})
      {:ok, %Destination{}}

      iex> update_destination(destination, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_destination(%Destination{} = destination, attrs) do
    destination
    |> Destination.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a destination.

  ## Examples

      iex> delete_destination(destination)
      {:ok, %Destination{}}

      iex> delete_destination(destination)
      {:error, %Ecto.Changeset{}}

  """
  def delete_destination(%Destination{} = destination) do
    Repo.delete(destination)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking destination changes.

  ## Examples

      iex> change_destination(destination)
      %Ecto.Changeset{data: %Destination{}}

  """
  def change_destination(%Destination{} = destination, attrs \\ %{}) do
    Destination.changeset(destination, attrs)
  end

  @doc """
  Returns a querybale with preloaded destination assets.
  """
  def preload_assoc_query(queryable, assocs \\ [:destination_asset]) do
    from(q in queryable, preload: ^assocs)
  end

  @doc """
  Returns a list of destination filtered by search query.

  ## Examples

      iex> filtered_query(%{category: "beach"})
      [%Destination{}, ...]
  """
  def filtered_query(queryable \\ Destination, filters) when is_map(filters) do
    Enum.reduce(filters, queryable, fn {k, v}, query_accum ->
      cond do
        v in [nil, ""] ->
          query_accum

        k == "category" ->
          from d in query_accum,
            where: d.tag == ^v

        k == "destination" ->
          from d in query_accum,
            where: ilike(d.name, ^"%#{v}%"),
            or_where: ilike(fragment("?->>'street'", d.address), ^"%#{v}%")

        k == "city" ->
          from d in query_accum,
            where: ilike(fragment("?->>'city'", d.address), ^"%#{v}%"),
            or_where: ilike(fragment("?->>'town'", d.address), ^"%#{v}%")

        true ->
          query_accum
      end
    end)
  end

  alias CoolPlaces.Destinations.DestinationAsset

  @doc """
  Returns the list of destination_assets.

  ## Examples

      iex> list_destination_assets()
      [%DestinationAsset{}, ...]

  """
  def list_destination_assets do
    Repo.all(DestinationAsset)
  end

  @doc """
  Gets a single destination_asset.

  Raises `Ecto.NoResultsError` if the Destination asset does not exist.

  ## Examples

      iex> get_destination_asset!(123)
      %DestinationAsset{}

      iex> get_destination_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_destination_asset!(id), do: Repo.get!(DestinationAsset, id)

  @doc """
  Creates a destination_asset.

  ## Examples

      iex> create_destination_asset(%{field: value})
      {:ok, %DestinationAsset{}}

      iex> create_destination_asset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_destination_asset(attrs \\ %{}) do
    %DestinationAsset{}
    |> DestinationAsset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a destination_asset.

  ## Examples

      iex> update_destination_asset(destination_asset, %{field: new_value})
      {:ok, %DestinationAsset{}}

      iex> update_destination_asset(destination_asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_destination_asset(%DestinationAsset{} = destination_asset, attrs) do
    destination_asset
    |> DestinationAsset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a destination_asset.

  ## Examples

      iex> delete_destination_asset(destination_asset)
      {:ok, %DestinationAsset{}}

      iex> delete_destination_asset(destination_asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_destination_asset(%DestinationAsset{} = destination_asset) do
    Repo.delete(destination_asset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking destination_asset changes.

  ## Examples

      iex> change_destination_asset(destination_asset)
      %Ecto.Changeset{data: %DestinationAsset{}}

  """
  def change_destination_asset(%DestinationAsset{} = destination_asset, attrs \\ %{}) do
    DestinationAsset.changeset(destination_asset, attrs)
  end

  alias CoolPlaces.Destinations.DestinationAssetMapping

  @doc """
  Returns the list of destination_asset_mapping.

  ## Examples

      iex> list_destination_asset_mapping()
      [%DestinationAssetMapping{}, ...]

  """
  def list_destination_asset_mapping do
    Repo.all(DestinationAssetMapping)
  end

  @doc """
  Gets a single destination_asset_mapping.

  Raises `Ecto.NoResultsError` if the Destination asset mapping does not exist.

  ## Examples

      iex> get_destination_asset_mapping!(123)
      %DestinationAssetMapping{}

      iex> get_destination_asset_mapping!(456)
      ** (Ecto.NoResultsError)

  """
  def get_destination_asset_mapping!(id), do: Repo.get!(DestinationAssetMapping, id)

  @doc """
  Deletes a destination_asset_mapping.

  ## Examples

      iex> delete_destination_asset_mapping(destination_asset_mapping)
      {:ok, %DestinationAssetMapping{}}

      iex> delete_destination_asset_mapping(destination_asset_mapping)
      {:error, %Ecto.Changeset{}}

  """
  def delete_destination_asset_mapping(%DestinationAssetMapping{} = destination_asset_mapping) do
    Repo.delete(destination_asset_mapping)
  end
end

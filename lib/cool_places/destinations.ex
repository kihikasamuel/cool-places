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
  def list_destinations do
    Repo.all(Destination)
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
end

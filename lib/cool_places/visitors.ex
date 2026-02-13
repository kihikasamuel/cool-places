defmodule CoolPlaces.Visitors do
  @moduledoc """
  The Visitors context.
  """

  import Ecto.Query, warn: false
  alias CoolPlaces.Repo
  alias CoolPlaces.Visitors.Visitor
  alias CoolPlaces.Wrappers.Geolocation
  require Logger

  @doc """
  Returns the list of visitors.
  """
  def list_visitors do
    Repo.all(Visitor)
  end

  @doc """
  Gets visitor data for map display.
  Returns a list of maps with latitude, longitude, and basic info.
  """
  def get_map_data do
    from(v in Visitor,
      select: %{
        id: v.id,
        lat: v.latitude,
        lng: v.longitude,
        city: v.city,
        country: v.country,
        visited_at: v.visited_at
      },
      order_by: [desc: v.visited_at],
      limit: 1000
    )
    |> Repo.all()
  end

  @doc """
  Creates a visitor.
  """
  def create_visitor(attrs \\ %{}) do
    %Visitor{}
    |> Visitor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns visitor statistics.
  """
  def get_visitor_stats do
    total_visitors = Repo.one(from v in Visitor, select: count(v.id))
    unique_countries = Repo.one(from v in Visitor, select: count(v.country_code, :distinct))

    %{
      total_visitors: total_visitors || 0,
      unique_countries: unique_countries || 0
    }
  end

  @doc """
  Tracks a visitor identifying them by their IP address hash.
  """
  def track_visitor(ip, user_agent \\ nil) do
    ip_hash = Geolocation.hash_ip(ip)

    res =
      case Geolocation.lookup(ip) do
        {:error, reason} ->
          {:error, reason}

        geo_data ->
          geo_data
          |> Map.put(:ip_address_hash, ip_hash)
          |> Map.put(:user_agent, user_agent)
          |> Map.put(:visited_at, DateTime.utc_now() |> DateTime.truncate(:second))
          |> create_visitor()
      end

    Logger.info("log visitor: #{inspect(res, pretty: true)}")
  end
end

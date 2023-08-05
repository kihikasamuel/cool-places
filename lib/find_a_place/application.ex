defmodule FindAPlace.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FindAPlace.Repo,
      # Start the Telemetry supervisor
      FindAPlaceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FindAPlace.PubSub},
      # Start the Endpoint (http/https)
      FindAPlaceWeb.Endpoint,
      # Start a worker by calling: FindAPlace.Worker.start_link(arg)
      # {FindAPlace.Worker, arg}
      # {ConCache, [name: :places_cache, ttl_check_interval: false]}
      {Cachex, name: :places_cache}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FindAPlace.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FindAPlaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

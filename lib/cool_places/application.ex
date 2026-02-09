defmodule CoolPlaces.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CoolPlacesWeb.Telemetry,
      CoolPlaces.Repo,
      {DNSCluster, query: Application.get_env(:cool_places, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CoolPlaces.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch,
       name: CoolPlaces.Finch,
       pools: %{
         default: [
           size: 10,
           count: 2,
           conn_opts: [transport_opts: [verify: ca_verify_options()]]
         ]
       }},
      # Start a worker by calling: CoolPlaces.Worker.start_link(arg)
      # {CoolPlaces.Worker, arg},
      # Start to serve requests, typically the last entry
      CoolPlacesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CoolPlaces.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoolPlacesWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp ca_verify_options() do
    if Application.get_env(:cool_places, :env) in [:dev, :test] do
      :verify_none
    else
      :verify_peer
    end
  end
end

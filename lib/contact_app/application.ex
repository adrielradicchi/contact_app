defmodule ContactApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      # Start the Telemetry supervisor
      ContactAppWeb.Telemetry,
      # Start the Ecto repository
      ContactApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ContactApp.PubSub},
      # Start Finch
      {Finch, name: ContactApp.Finch},
      # Start the Endpoint (http/https)
      ContactAppWeb.Endpoint,
      # Start a worker by calling: ContactApp.Worker.start_link(arg)
      # {ContactApp.Worker, arg}
      ContractApp.PromEx,

      {Cluster.Supervisor, [topologies, [name: ContactApp.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ContactApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ContactAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

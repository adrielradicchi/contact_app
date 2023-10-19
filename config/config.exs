# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :contact_app,
  ecto_repos: [ContactApp.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :contact_app, ContactAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ContactAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ContactApp.PubSub,
  live_view: [signing_salt: "vwY51PI1"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :contact_app, ContactApp.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :contact_app, ContactApp.PromEx,
  manual_metrics_start_delay: :no_delay

config :libcluster,
  topologies: [
    erlang_nodes_in_k8s: [
      strategy: Elixir.Cluster.Strategy.Kubernetes,
      config: [
        mode: :ip,
        kubernetes_node_basename: "contact-app",
        kubernetes_selector: "app=contact-app",
        kubernetes_namespace: "contact-app",
        polling_interval: 10_000
      ]
    ]
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

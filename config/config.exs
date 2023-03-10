# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :project_manager,
  ecto_repos: [ProjectManager.Repo]

# Configures the endpoint
config :project_manager, ProjectManagerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ProjectManagerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ProjectManager.PubSub,
  live_view: [signing_salt: "O1DWPSRM"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :project_manager, ProjectManager.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :project_manager, ProjectManagerWeb.Auth.Guardian,
  issuer: "project_manager",
  allowed_algos: ["RS512"],
  secret_fetcher: ProjectManagerWeb.Auth.SecretFetcher

config :project_manager, ProjectManagerWeb.Auth.Pipeline,
  module: ProjectManagerWeb.Auth.Guardian,
  error_handler: ProjectManagerWeb.Auth.ErrorHandler

config :cors_plug,
  origin: ["http://localhost:3000", "https://hellhat.com", "https://www.hellhat.com"],
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "PATCH", "DELETE"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

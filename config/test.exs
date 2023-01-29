import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :project_manager, ProjectManager.Repo,
  username: "postgres",
  password: "batata123",
  hostname: "localhost",
  database: "project_manager_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :project_manager, ProjectManagerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ZzyfYGK9AYAE/Ty2P2tuZWEl2GEUAMFZIHCCc3ajrnkdppT9eRw3p8YnBzPG+dmE",
  server: false

# In test we don't send emails.
config :project_manager, ProjectManager.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :project_manager, ProjectManager.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "hellhat",
  ssl: true,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

defmodule ProjectManager.Repo do
  use Ecto.Repo,
    otp_app: :project_manager,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, max_page_size: 50
end

defmodule ProjectManager.Repo.Migrations.AddProjectTable do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :repo, :string
      add :description, :string
      add :profile_id, references(:profiles, type: :uuid, on_delete: :delete_all), null: false
      timestamps()
    end
  end
end

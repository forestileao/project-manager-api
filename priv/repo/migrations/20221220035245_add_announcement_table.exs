defmodule ProjectManager.Repo.Migrations.AddAnnouncementTable do
  use Ecto.Migration

  def change do
    create table(:announcements, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :body, :string
      timestamps()
    end
  end
end

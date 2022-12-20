defmodule ProjectManager.Repo.Migrations.AnnouncementBelongsToProfile do
  use Ecto.Migration

  def change do
    alter table(:announcements) do
      add :profile_id, references(:profiles, type: :uuid, on_delete: :delete_all), null: false
    end
  end
end

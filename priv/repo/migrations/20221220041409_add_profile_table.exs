defmodule ProjectManager.Repo.Migrations.AddProfileTable do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string
      add :email, :string
      add :avatar, :string
      add :description, :string
      add :password_hash, :string
      timestamps()
    end
  end
end

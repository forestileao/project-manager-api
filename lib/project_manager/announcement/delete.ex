defmodule ProjectManager.Announcement.Delete do
  alias Ecto.UUID
  alias ProjectManager.Repo
  alias ProjectManager.Announcement

  def call(%{"id" => id}) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid id format!"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(Announcement, id) do
      {:error, _changeset} = error -> error
      {:ok, announcement} -> Repo.delete(announcement)
    end
  end
end

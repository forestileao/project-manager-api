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
      nil -> {:error, "Announcement not found!", :not_found}
      announcement -> Repo.delete(announcement)
    end
  end
end

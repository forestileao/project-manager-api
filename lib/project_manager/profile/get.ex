defmodule ProjectManager.Profile.Get do
  alias Ecto.UUID
  alias ProjectManager.Profile
  alias ProjectManager.Repo

  def call(%{"id" => id}) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid id format!", :bad_request}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(Profile, id) do
      nil -> {:error, "Profile not found!", :not_found}
      profile -> {:ok, profile}
    end
  end
end

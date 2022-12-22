defmodule ProjectManager.Profile.Get do
  alias Postgrex.Extensions.UUID
  alias Ecto.UUID
  alias ProjectManager.Profile
  alias ProjectManager.Repo

  def call(%{"id" => id}) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid id format!"}
      {:ok, _uuid} -> get(id)
    end
  end

  defp get(id) do
    case Repo.get(Profile, id) do
      nil -> {:error, "Profile not found!"}
      profile -> {:ok, profile}
    end
  end
end

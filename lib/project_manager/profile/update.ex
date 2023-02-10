defmodule ProjectManager.Profile.Update do
  alias Ecto.UUID

  alias ProjectManager.Profile
  alias ProjectManager.Repo

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, _id} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    id
    |> fetch_profile()
    |> handle_update(params)
  end

  defp fetch_profile(id) do
    case Profile |> Repo.get(id) do
      %Profile{} = profile -> {:ok, profile}
      nil -> {:error, "Profile not found!", :not_found}
    end
  end

  defp handle_update({:ok, profile}, params) do
    profile
    |> Profile.changeset(params)
    |> Repo.update()
  end

  defp handle_update(error, _), do: error
end

defmodule ProjectManager.Profile.Create do
  alias ProjectManager.Profile
  alias ProjectManager.Repo

  def call(params) do
    for {key, val} <- params, into: %{} do
      {String.to_atom(key), val}
    end
    |> Profile.build()
    |> handle_build()
  end

  defp handle_build({:ok, profile}), do: Repo.insert(profile)
  defp handle_build({:error, _changeset} = error), do: error
end

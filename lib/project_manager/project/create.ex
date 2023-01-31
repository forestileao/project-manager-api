defmodule ProjectManager.Project.Create do
  alias ProjectManager.Repo
  alias ProjectManager.Project

  def call(params) do
    params
    |> Project.build()
    |> handle_create()
  end

  defp handle_create({:ok, project}), do: Repo.insert(project)
  defp handle_create({:error, _changeset} = error), do: error
end

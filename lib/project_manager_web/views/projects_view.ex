defmodule ProjectManagerWeb.ProjectsView do
  use ProjectManagerWeb, :view

  def render("create.json", %{project: project}) do
    %{
      message: "Project Created!",
      project: project |> Map.take([:id, :repo, :description, :inserted_at])
    }
  end

  def render("list.json", %{result: result}) do
    result
    |> Enum.map(fn profile ->
      profile |> Map.take([:id, :username, :projects])
    end)
  end
end

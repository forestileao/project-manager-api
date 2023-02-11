defmodule ProjectManager.Project.List do
  import Ecto.Query

  alias ProjectManager.{Profile, Repo}

  def call(_) do
    result =
      Profile
      |> select([:id, :username])
      |> join(:left, [profile], project in assoc(profile, :projects))
      |> preload([_profile, project], projects: project)
      |> order_by([profile, project], desc: project.inserted_at, desc: profile.inserted_at)
      |> Repo.all()

    {:ok, result}
  end
end

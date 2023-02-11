defmodule ProjectManager.Profile.List do
  import Ecto.Query
  alias ProjectManager.{Profile, Repo}

  def call() do
    profiles =
      Profile
      |> select([:id, :username, :email, :description, :avatar])
      |> Repo.all()

    {:ok, profiles}
  end
end

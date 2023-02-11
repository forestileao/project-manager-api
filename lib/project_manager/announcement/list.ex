defmodule ProjectManager.Announcement.List do
  alias ProjectManager.Repo
  alias ProjectManager.Announcement

  import Ecto.Query

  def call(params) do
    result =
      Announcement
      |> order_by(desc: :inserted_at)
      |> preload(:profile)
      |> Repo.paginate(params)

    {:ok, result}
  end
end

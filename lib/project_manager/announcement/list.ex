defmodule ProjectManager.Announcement.List do
  alias ProjectManager.Repo
  alias ProjectManager.Announcement

  import Ecto.Query

  def call(params) do
    Announcement
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(params)
  end
end

defmodule ProjectManager.Announcement.List do
  alias ProjectManager.Repo
  alias ProjectManager.Announcement

  import Ecto.Query

  def call(%{"page_number" => page_number, "page_size" => page_size}) do
    result =
      Announcement
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(page: page_number, page_size: page_size)

    {:ok, result}
  end

  def call(_),
    do: {:error, "Invalid parameters!", :bad_request}
end

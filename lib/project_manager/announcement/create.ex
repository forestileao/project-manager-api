defmodule ProjectManager.Announcement.Create do
  alias ProjectManager.Repo
  alias ProjectManager.Announcement

  def call(params) do
    for {key, val} <- params, into: %{} do
      {String.to_atom(key), val}
    end
    |> create()
  end

  defp create(params) do
    case Announcement.build(params) do
      {:ok, announcement} -> Repo.insert(announcement)
      {:error, _changeset} = error -> error
    end
  end
end

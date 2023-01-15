defmodule ProjectManagerWeb.AnnouncementsView do
  use ProjectManagerWeb, :view

  def render("list.json", %{entries: entries} = paged_response) do
    paged_response
    |> Map.put(:entries, entries |> Enum.map(&translate_response/1))
  end

  def render("create.json", %{announcement: announcement}) do
    translate_response(announcement)
  end

  defp translate_response(%{profile: profile} = announcement) do
    announcement
    |> Map.take([:id, :title, :body, :inserted_at, :profile])
    |> Map.put(:profile, %{id: profile.id, username: profile.username})
  end
end

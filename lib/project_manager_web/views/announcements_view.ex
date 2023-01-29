defmodule ProjectManagerWeb.AnnouncementsView do
  use ProjectManagerWeb, :view

  require Protocol
  Protocol.derive(Jason.Encoder, Scrivener.Page)

  def render("index.json", %{paged_result: paged_result}) do
    paged_result
    |> Map.put(:entries, paged_result.entries |> Enum.map(&translate_response/1))
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

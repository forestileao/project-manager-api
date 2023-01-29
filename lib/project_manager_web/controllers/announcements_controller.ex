defmodule ProjectManagerWeb.AnnouncementsController do
  use ProjectManagerWeb, :controller
  import ProjectManagerWeb.Auth.Guardian, only: [load_current_profile: 2]

  plug :load_current_profile

  action_fallback ProjectManagerWeb.FallbackController

  @spec create(atom | %{:assigns => nil | maybe_improper_list | map, optional(any) => any}, any) ::
          any
  def create(conn, params) do
    profile = conn.assigns[:current_profile]
    params = params |> Map.put("profile_id", profile.id)

    with {:ok, announcement} <-
           ProjectManager.create_announcement(params) do
      announcement = announcement |> Map.put(:profile, profile)
      handle_response(conn, :created, "create.json", %{announcement: announcement})
    end
  end

  def index(conn, params) do
    with {:ok, paged_result} <- ProjectManager.list_announcement(params) do
      handle_response(conn, :ok, "index.json", paged_result)
    end
  end

  def delete(conn, %{"id" => _} = params) do
    with {:ok, _} <- ProjectManager.delete_announcement(params) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  defp handle_response(conn, status, view, result) do
    conn
    |> put_status(status)
    |> render(view, result)
  end
end

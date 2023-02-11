defmodule ProjectManagerWeb.ProjectsController do
  use ProjectManagerWeb, :controller

  import ProjectManagerWeb.Auth.Guardian, only: [load_current_profile: 2]

  plug :load_current_profile

  action_fallback ProjectManagerWeb.FallbackController

  def index(conn, params) do
    with {:ok, result} <- ProjectManager.list_projects(params) do
      conn
      |> handle_response(:ok, "list.json", %{result: result})
    end
  end

  def create(conn, params) do
    profile = conn.assigns[:current_profile]
    params = params |> Map.put("profile_id", profile.id)

    with {:ok, project} <- ProjectManager.create_project(params) do
      conn
      |> handle_response(:created, "create.json", %{project: project})
    end
  end

  defp handle_response(conn, status, view, result) do
    conn
    |> put_status(status)
    |> render(view, result)
  end
end

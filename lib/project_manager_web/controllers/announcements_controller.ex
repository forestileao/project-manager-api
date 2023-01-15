defmodule ProjectManagerWeb.AnnouncementsController do
  use ProjectManagerWeb, :controller

  action_fallback ProjectManagerWeb.FallbackController

  def create(conn, params) do
    with {:ok, announcement} <- ProjectManager.create_announcement(params) do
      handle_response(conn, :created, "create.json", %{announcement: announcement})
    end
  end

  def list(conn, params) do
    with {:ok, paged_result} <- ProjectManager.list_announcement(params) do
      handle_response(conn, :ok, "list.json", paged_result)
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

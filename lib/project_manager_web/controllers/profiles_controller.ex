defmodule ProjectManagerWeb.ProfilesController do
  use ProjectManagerWeb, :controller

  action_fallback ProjectManagerWeb.FallbackController

  def create(conn, params) do
    with {:ok, profile} <- ProjectManager.create_profile(params) do
      conn
      |> handle_response(:created, "create.json", %{profile: profile, token: ""})
    end
  end

  def show(conn, params) do
    with {:ok, profile} <- ProjectManager.fetch_profile(params) do
      conn
      |> handle_response(:ok, "show.json", %{profile: profile})
    end
  end

  defp handle_response(conn, status, view, result) do
    conn
    |> put_status(status)
    |> render(view, result)
  end
end

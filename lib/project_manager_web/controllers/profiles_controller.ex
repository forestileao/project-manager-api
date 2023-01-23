defmodule ProjectManagerWeb.ProfilesController do
  use ProjectManagerWeb, :controller

  alias ProjectManagerWeb.Auth.Guardian

  action_fallback ProjectManagerWeb.FallbackController

  def sign_in(conn, %{"username" => _, "password" => _} = params) do
    with {:ok, token, profile} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", %{token: token, profile: profile})
    end
  end

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

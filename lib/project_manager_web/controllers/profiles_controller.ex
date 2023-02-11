defmodule ProjectManagerWeb.ProfilesController do
  use ProjectManagerWeb, :controller

  import ProjectManagerWeb.Auth.Guardian,
    only: [authenticate: 1, load_current_profile: 2, encode_and_sign: 1]

  plug :load_current_profile

  action_fallback ProjectManagerWeb.FallbackController

  def sign_in(conn, %{"username" => _, "password" => _} = params) do
    with {:ok, token, profile} <- authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", %{token: token, profile: profile})
    end
  end

  def create(conn, params) do
    with {:ok, profile} <- ProjectManager.create_profile(params),
         {:ok, token, _claims} <- encode_and_sign(profile) do
      conn
      |> handle_response(:created, "create.json", %{profile: profile, token: token})
    end
  end

  def update(conn, params) do
    profile = conn.assigns[:current_profile]
    params = params |> Map.put("id", profile.id)

    with {:ok, profile} <- ProjectManager.update_profile(params) do
      conn
      |> handle_response(:ok, "update.json", %{profile: profile})
    end
  end

  def show(conn, params) do
    with {:ok, profile} <- ProjectManager.fetch_profile(params) do
      conn
      |> handle_response(:ok, "show.json", %{profile: profile})
    end
  end

  def index(conn, _) do
    with {:ok, profiles} <- ProjectManager.list_profiles() do
      conn
      |> handle_response(:ok, "list.json", %{profiles: profiles})
    end
  end

  defp handle_response(conn, status, view, result) do
    conn
    |> put_status(status)
    |> render(view, result)
  end
end

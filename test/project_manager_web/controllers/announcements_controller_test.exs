defmodule ProjectManagerWeb.AnnouncementsControllerTest do
  use ProjectManagerWeb.ConnCase, async: true

  import ProjectManagerWeb.Auth.Guardian

  alias ProjectManager.Profile

  describe "create/2" do
    setup %{conn: conn} do
      params = %{username: "Pedro", email: "test@pedro.com", password: "123456"}
      {:ok, profile} = ProjectManager.create_profile(params)
      {:ok, token, _claims} = encode_and_sign(profile)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when a profile id is logged in, creates an announcement", %{conn: conn} do
      params = %{title: "test title", body: "test body"}

      response =
        conn
        |> post(Routes.announcements_path(conn, :create, params))
        |> json_response(:created)

      assert %{"id" => _id, "title" => "test title", "body" => "test body"} = response
    end

    test "when a profile id is not logged in, returns an unauthorized error" do
      params = %{title: "test title", body: "test body"}
      conn = build_conn()

      response =
        conn
        |> post(Routes.announcements_path(conn, :create, params))

      assert response.status == 401
    end
  end
end

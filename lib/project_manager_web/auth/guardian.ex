defmodule ProjectManagerWeb.Auth.Guardian do
  use Guardian, otp_app: :project_manager

  alias ProjectManager.{Repo, Profile}

  import Ecto.Query
  import Plug.Conn

  def subject_for_token(profile, _claims) do
    sub = to_string(profile.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id =
      claims
      |> Map.get("sub")

    ProjectManager.fetch_profile(%{"id" => id})
  end

  def authenticate(%{"username" => username, "password" => password}) do
    result = Profile |> where(username: ^username) |> first() |> Repo.one()

    case result do
      nil -> {:error, "Profile not found!"}
      profile -> validate_password(profile, password)
    end
  end

  def load_current_profile(conn, _) do
    conn
    |> assign(:current_profile, Guardian.Plug.current_resource(conn))
  end

  defp validate_password(%Profile{password_hash: hash} = profile, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(profile)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(profile) do
    {:ok, token, _claims} = encode_and_sign(profile)
    {:ok, token, profile}
  end
end

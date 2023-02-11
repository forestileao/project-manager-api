defmodule ProjectManager.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProjectManager.{Announcement, Project}

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "profiles" do
    field(:username, :string)
    field(:email, :string)
    field(:avatar, :string)
    field(:description, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    has_many(:announcements, Announcement)
    has_many(:projects, Project)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_fields [:username, :email, :password]
  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  def changeset(%__MODULE__{} = profile, params), do: update_changeset(profile, params)

  @mail_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  defp create_changeset(profile, params) do
    profile
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, @mail_regex)
    |> put_password_hash()
  end

  defp update_changeset(profile, params) do
    profile
    |> cast(params, [:email, :avatar, :description])
    |> validate_required([:email])
    |> validate_format(:email, @mail_regex)
    |> validate_url()
  end

  defp validate_url(changeset) do
    validate_change(changeset, :avatar, fn :avatar, value ->
      case URI.parse(value) do
        %URI{scheme: "https", path: path} when not is_nil(path) -> []
        %URI{scheme: "http", path: path} when not is_nil(path) -> []
        _ -> [avatar: "is not a valid URL"]
      end
    end)
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end

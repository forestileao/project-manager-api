defmodule ProjectManager.Announcement do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProjectManager.Profile

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "announcements" do
    field(:title, :string)
    field(:body, :string)
    belongs_to(:profile, Profile)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:title, :body]
  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  defp create_changeset(announcement, params) do
    announcement
    |> cast(params, @required_params)
    |> assoc_constraint(:profile)
    |> validate_required(@required_params)
    |> validate_length(:title, max: 30)
    |> validate_length(:body, max: 5000)
  end
end

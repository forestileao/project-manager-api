defmodule ProjectManager.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProjectManager.Profile

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "projects" do
    field(:repo, :string)
    field(:description, :string)
    belongs_to(:profile, Profile)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:repo, :description, :profile_id]

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  defp create_changeset(project, params) do
    project
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:repo, min: 1, max: 50)
    |> validate_length(:description, max: 2000)
  end
end

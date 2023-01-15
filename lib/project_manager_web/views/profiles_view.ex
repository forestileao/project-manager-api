defmodule ProjectManagerWeb.ProfilesView do
  use ProjectManagerWeb, :view

  @public_fields [:username, :email, :inserted_at]

  def render("create.json", %{profile: profile, token: token}) do
    %{
      message: "Profile Created!",
      profile: profile |> Map.take(@public_fields),
      token: token
    }
  end

  def render("show.json", %{profile: profile}) do
    %{
      profile: profile |> Map.take(@public_fields)
    }
  end
end

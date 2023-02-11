defmodule ProjectManagerWeb.ProfilesView do
  use ProjectManagerWeb, :view

  @public_fields [:id, :username, :email, :avatar, :description]

  def render("create.json", %{profile: profile, token: token}) do
    %{
      message: "Profile Created!",
      profile: profile |> Map.take(@public_fields),
      token: token
    }
  end

  def render("update.json", %{profile: profile}) do
    %{
      message: "Profile Updated!",
      profile: profile |> Map.take(@public_fields)
    }
  end

  def render("show.json", %{profile: profile}) do
    %{
      profile: profile |> Map.take(@public_fields)
    }
  end

  def render("list.json", %{profiles: profiles}) do
    profiles
    |> Enum.map(fn profile -> profile |> Map.take(@public_fields) end)
  end

  def render("sign_in.json", %{token: token, profile: profile}) do
    %{
      token: token,
      profile: profile |> Map.take(@public_fields)
    }
  end
end

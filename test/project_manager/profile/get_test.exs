defmodule ProjectManager.Profile.GetTest do
  use ProjectManager.DataCase

  alias ProjectManager.{Repo, Profile}
  alias Profile.Get

  describe "call/1" do
    setup do
      params = %{username: "Pedro", email: "test@test.com", password: "123456"}

      {:ok, profile} = Profile.Create.call(params)

      {:ok, profile: profile |> Map.put(:password, nil)}
    end

    test "when the profile exists, returns the profile itself", state do
      %{id: id} = state[:profile]

      {:ok, profile} = Get.call(%{"id" => id})

      assert profile == state[:profile]
    end

    test "when the profile doesn't exists, returns an error", state do
      id = Ecto.UUID.autogenerate()

      response = Get.call(%{"id" => id})

      assert response == {:error, "Profile not found!", :not_found}
    end
  end
end

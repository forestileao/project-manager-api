defmodule ProjectManager.Profile.UpdateTest do
  use ProjectManager.DataCase, async: true
  alias ProjectManager.Profile.{Create, Update}

  describe "call/1" do
    setup do
      params = %{username: "test", email: "test@test.com", password: "test_123"}

      {:ok, profile} = Create.call(params)

      {:ok, profile: profile}
    end

    test "when all update params are valid, update it", state do
      %{id: id} = state[:profile]

      update_params = %{
        "id" => id,
        "avatar" => "http://test.com/image.png",
        "description" => "new description",
        "email" => "email@email.com"
      }

      updated_profile = Update.call(update_params)

      %{
        "avatar" => expected_avatar,
        "description" => expected_description,
        "email" => expected_email
      } = update_params

      assert {:ok,
              %{
                avatar: ^expected_avatar,
                email: ^expected_email,
                description: ^expected_description
              }} = updated_profile
    end

    test "when any update param is invalid, returns an error", state do
      %{id: id} = state[:profile]

      update_params = %{
        "id" => id,
        "avatar" => "not.valid.url",
        "email" => "invalid_email"
      }

      updated_profile = Update.call(update_params)

      assert {:error,
              %{
                valid?: false,
                errors: [
                  avatar: {"is not a valid URL", []},
                  email: {"has invalid format", [validation: :format]}
                ]
              }} = updated_profile
    end
  end
end

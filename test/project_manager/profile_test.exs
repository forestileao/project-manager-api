defmodule ProjectManager.ProfileTest do
  use ExUnit.Case, async: true
  use ProjectManager.DataCase

  alias ProjectManager.Profile

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{username: "testuser", email: "test@test.com", password: "test123"}

      response = Profile.changeset(params)

      assert %{
               action: nil,
               changes: %{username: "testuser", email: "test@test.com"},
               errors: [],
               valid?: true
             } = response
    end

    test "when any param is invalid, returns a valid changeset" do
      params = %{username: "testuser"}

      response = Profile.changeset(params)

      assert %{
               action: nil,
               valid?: false
             } = response

      assert errors_on(response) == %{
               email: ["can't be blank"],
               password: ["can't be blank"]
             }
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid Profile struct" do
      params = %{username: "testuser", email: "test@test.com", password: "test123"}

      response = Profile.build(params)

      assert {:ok, %Profile{username: "testuser", email: "test@test.com"}} = response
    end

    test "when any param is invalid, returns the invalid changeset" do
      params = %{username: "testuser"}

      {:error, changeset} = Profile.build(params)

      assert %Ecto.Changeset{valid?: false} = changeset

      assert errors_on(changeset) == %{
               email: ["can't be blank"],
               password: ["can't be blank"]
             }
    end
  end
end

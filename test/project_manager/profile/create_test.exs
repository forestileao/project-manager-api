defmodule ProjectManager.Profile.CreateTest do
  use ProjectManager.DataCase

  alias ProjectManager.{Repo, Profile}
  alias Profile.Create

  describe "call/1" do
    test "when all params are valid, creates a profile" do
      params = %{username: "Pedro", email: "test@test.com", password: "123456"}

      count_before = Repo.aggregate(Profile, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Profile, :count)

      assert {:ok, %Profile{username: "Pedro"}} = response
      assert count_after > count_before
    end

    test "when any params are invalid, returns an error" do
      params = %{username: "Pedro"}

      count_before = Repo.aggregate(Profile, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Profile, :count)

      assert {:error, _changeset} = response
      assert count_after == count_before
    end
  end
end

defmodule ProjectManager.Announcement.CreateTest do
  use ProjectManager.DataCase
  alias ProjectManager.{Announcement, Profile}
  alias Announcement.Create

  @profile_params %{username: "Pedro", email: "test@test.com", password: "123456"}

  describe "call/1" do
    setup do
      {:ok, profile} = Profile.Create.call(@profile_params)

      {:ok, profile: profile}
    end

    test "when all params are valid, create an announcement", state do
      profile = state[:profile]
      params = %{title: "title test", body: "body test", profile_id: profile.id}

      count_before = Repo.aggregate(Announcement, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Announcement, :count)

      assert {:ok, %Announcement{title: "title test"}} = response
      assert count_after > count_before
    end

    test "when any param is invalid, returns an error", state do
      profile = state[:profile]
      params = %{body: "body test", profile_id: profile.id}

      count_before = Repo.aggregate(Announcement, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Announcement, :count)

      assert {:error, _changeset} = response
      assert count_after == count_before
    end
  end
end

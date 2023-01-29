defmodule ProjectManager.AnnouncementTest do
  use ProjectManager.DataCase

  alias ProjectManager.{Profile, Announcement}

  describe "changeset/1" do
    setup do
      params = %{username: "testuser", email: "test@test.com", password: "test123"}
      {:ok, profile} = Profile.Create.call(params)

      {:ok, profile: profile}
    end

    test "when all params are valid, returns a valid changeset", state do
      profile = state[:profile]
      params = %{title: "title test", body: "body test", profile_id: profile.id}

      response = Announcement.changeset(params)

      assert %{
               action: nil,
               changes: %{body: "body test", title: "title test"},
               errors: [],
               valid?: true
             } = response
    end

    test "when any param is invalid, returns a valid changeset", state do
      profile = state[:profile]
      params = %{body: "body test", profile_id: profile.id}

      response = Announcement.changeset(params)

      assert %{
               action: nil,
               valid?: false
             } = response

      assert errors_on(response) == %{title: ["can't be blank"]}
    end
  end

  describe "build/1" do
    setup do
      params = %{username: "testuser", email: "test@test.com", password: "test123"}
      {:ok, profile} = Profile.Create.call(params)

      {:ok, profile: profile}
    end

    test "when all params are valid, returns a valid Announcement struct", state do
      profile = state[:profile]
      params = %{title: "title test", body: "body test", profile_id: profile.id}

      response = Announcement.build(params)

      assert {:ok, %Announcement{title: "title test", body: "body test"}} = response
    end

    test "when any param is invalid, returns the invalid changeset", state do
      profile = state[:profile]
      params = %{body: "body test", profile_id: profile.id}

      {:error, changeset} = Announcement.build(params)

      assert %Ecto.Changeset{valid?: false} = changeset
      assert errors_on(changeset) == %{title: ["can't be blank"]}
    end
  end
end

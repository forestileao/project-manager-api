defmodule ProjectManager.AnnouncementTest do
  use ExUnit.Case, async: true
  use ProjectManager.DataCase

  alias ProjectManager.{Profile, Announcement}

  setup_all state do
    params = %{username: "testuser", email: "test@test.com", password: "test123"}
    {:ok, profile} = Profile.build(params)

    {:ok, profile: profile}
  end

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset", state do
      params = %{title: "title test", body: "body test", profile: state[:profile]}

      response = Announcement.changeset(params)

      assert %{
               action: nil,
               changes: %{body: "body test", title: "title test"},
               errors: [],
               valid?: true
             } = response
    end

    test "when any param is invalid, returns a valid changeset", state do
      params = %{body: "body test", profile: state[:profile]}

      response = Announcement.changeset(params)

      assert %{
               action: nil,
               valid?: false
             } = response

      assert errors_on(response) == %{title: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid Announcement struct", state do
      params = %{title: "title test", body: "body test", profile: state[:profile]}

      response = Announcement.build(params)

      assert {:ok, %Announcement{title: "title test", body: "body test"}} = response
    end

    test "when any param is invalid, returns the invalid changeset", state do
      params = %{body: "body test", profile: state[:profile]}

      {:error, changeset} = Announcement.build(params)

      assert %Ecto.Changeset{valid?: false} = changeset
      assert errors_on(changeset) == %{title: ["can't be blank"]}
    end
  end
end

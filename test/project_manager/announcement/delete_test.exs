defmodule ProjectManager.Announcement.DeleteTest do
  use ProjectManager.DataCase, async: true
  alias ProjectManager.{Announcement, Profile}
  alias Announcement.{Create, Delete}

  @profile_params %{username: "Pedro", email: "test@test.com", password: "123456"}

  describe "call/1" do
    setup do
      {:ok, profile} = Profile.Create.call(@profile_params)

      params = %{title: "title test", body: "body test", profile_id: profile.id}

      {:ok, announcement} = Create.call(params)

      {:ok, announcement_id: announcement.id}
    end

    test "if the announcement exists, delete it", state do
      id = state[:announcement_id]

      count_before = Repo.aggregate(Announcement, :count)

      response = Delete.call(%{"id" => id})

      count_after = Repo.aggregate(Announcement, :count)

      assert {:ok, %Announcement{title: "title test"}} = response
      assert count_after < count_before
    end

    test "if the announcement doesn't exists, returns an error", state do
      id = Ecto.UUID.autogenerate()

      count_before = Repo.aggregate(Announcement, :count)

      response = Delete.call(%{"id" => id})

      count_after = Repo.aggregate(Announcement, :count)

      assert response = {:error, "Announcement not found!"}
      assert count_after == count_before
    end
  end
end

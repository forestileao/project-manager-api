defmodule ProjectManager do
  alias ProjectManager.{Announcement, Profile}

  defdelegate create_profile(params), to: Profile.Create, as: :call
  defdelegate fetch_profile(params), to: Profile.Get, as: :call

  defdelegate list_announcement(params), to: Announcement.List, as: :call
  defdelegate create_announcement(params), to: Announcement.Create, as: :call
  defdelegate delete_announcement(params), to: Announcement.Delete, as: :call
end

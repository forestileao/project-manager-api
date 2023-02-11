defmodule ProjectManager do
  alias ProjectManager.{Announcement, Profile, Project}

  defdelegate create_profile(params), to: Profile.Create, as: :call
  defdelegate fetch_profile(params), to: Profile.Get, as: :call
  defdelegate update_profile(params), to: Profile.Update, as: :call
  defdelegate list_profiles(), to: Profile.List, as: :call

  defdelegate list_announcement(params), to: Announcement.List, as: :call
  defdelegate create_announcement(params), to: Announcement.Create, as: :call
  defdelegate delete_announcement(params), to: Announcement.Delete, as: :call

  defdelegate list_projects(params), to: Project.List, as: :call
  defdelegate create_project(params), to: Project.Create, as: :call
end

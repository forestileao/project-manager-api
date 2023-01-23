defmodule ProjectManagerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :project_manager

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end

defmodule ProjectManagerWeb.FallbackController do
  use ProjectManagerWeb, :controller
  import Plug.Conn.Status, only: [code: 1]

  def call(conn, {:error, result, status}) do
    conn
    |> put_status(status)
    |> put_view(ProjectManagerWeb.ErrorView)
    |> render("#{code(status)}.json", result: result)
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ProjectManagerWeb.ErrorView)
    |> render("400.json", result: result)
  end
end

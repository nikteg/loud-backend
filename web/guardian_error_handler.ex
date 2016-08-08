defmodule LoudBackend.GuardianErrorHandler do
  use LoudBackend.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(LoudBackend.ErrorView, "401.json")
  end
end
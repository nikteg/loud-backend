defmodule LoudBackend.GuardianErrorHandler do
  use Phoenix.Controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> json(%{error: "Unauthenticated"})
  end
end
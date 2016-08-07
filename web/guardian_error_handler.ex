defmodule LoudBackend.GuardianErrorHandler do

  def unauthenticated(conn, _params) do
    conn
    |> Phoenix.Controller.render(LoudBackend.ErrorView, "500.json")
  end
end
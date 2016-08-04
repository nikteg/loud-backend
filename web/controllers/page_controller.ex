defmodule LoudBackend.PageController do
  use LoudBackend.Web, :controller

  def index(conn, _params) do
    text conn, "Welcome to the Loud Backend v#{Mix.Project.config[:version]}"
  end
end
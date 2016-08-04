defmodule LoudBackend.PageController do
  use LoudBackend.Web, :controller

  alias LoudBackend.Mixfile

  def index(conn, _params) do
    IO.inspect LoudBackend
    text conn, "hey"
  end
end
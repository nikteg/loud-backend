defmodule LoudBackend.PageController do
  use LoudBackend.Web, :controller

  def index(conn, _params) do
    text conn, """
\s\s\s\s_
\s\\_|_)\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s|
\s\s\s|\s\s\s\s\s__\s\s\s\s\s\s\s\s\s\s__|
\s\s_|\s\s\s\s/\s\s\\_|\s\s\s|\s\s/\s\s|
\s(/\\___/\\__/\s\s\\_/|_/\\_/|_/\sv#{Mix.Project.config[:version]}
    """
  end
end
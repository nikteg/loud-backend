defmodule LoudBackend.UserView do
  use LoudBackend.Web, :view

  def render("login.json", %{jwt: jwt, exp: exp}) do
    %{jwt: jwt,
      exp: exp}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end

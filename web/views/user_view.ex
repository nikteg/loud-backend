defmodule LoudBackend.UserView do
  use LoudBackend.Web, :view

  def render("login.json", %{jwt: jwt, exp: exp}) do
    %{jwt: jwt,
      exp: exp}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      password: user.password}
  end
end

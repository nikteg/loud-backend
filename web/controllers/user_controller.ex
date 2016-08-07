defmodule LoudBackend.UserController do
  use LoudBackend.Web, :controller

  alias LoudBackend.User

  # plug Guardian.Plug.EnsureAuthenticated, handler: LoudBackend.GuardianErrorHandler when not action in [:new, :create]

  defp signIn(conn, user) do
    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {:ok, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    new_conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> put_resp_header("x-exp", Integer.to_string(exp))
    |> render("login.json", %{jwt: jwt, exp: exp})
  end

  def register(conn, %{"name" => name, "password" => password}) do
    changeset = User.changeset(%User{}, %{name: name, password: password})

    if changeset.valid? do
      {_, user} = Repo.insert(changeset)
      signIn(conn, user)
    else
      conn
      |> put_status(401)
      |> render("error.json", message: "Could not login")
    end
  end

  def login(conn, %{"user" => user_params}) do
    case User.find_and_confirm_password(user_params) do
      {:ok, user} ->
        signIn(conn, user)
      {:error, nil} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end

  # def logout(conn, %{}) do
  #   conn
  #   |> Guardian.Plug.logout
  #   |> render "logout.json", message: "Logged out"
  # end
end

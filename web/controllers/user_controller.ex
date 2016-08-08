defmodule LoudBackend.UserController do
  use LoudBackend.Web, :controller

  alias LoudBackend.User

  # plug Guardian.Plug.EnsureAuthenticated, handler: LoudBackend.GuardianErrorHandler when not action in [:new, :create]

  defp generate_jwt_and_render(conn, user) do
    IO.inspect user
    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {:ok, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    new_conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> put_resp_header("x-exp", Integer.to_string(exp))
    |> render("login.json", %{jwt: jwt, exp: exp})
  end

  def register(conn, %{"username" => username, "password" => password}) do
    changeset = User.register_changeset(%User{}, %{username: username, password: password})

    case Repo.insert(changeset) do
      {:ok, user} ->
        generate_jwt_and_render(conn, user)
      {:error, changeset} ->
        message = changeset.errors
          |> Enum.map(fn({key, {message, _}}) -> ("#{key} #{message}" |> String.capitalize) end)
          |> Enum.join(", ")

        conn
        |> put_status(401)
        |> render("error.json", message: message)
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    user = Repo.get_by(User, username: username)

    case authenticate(user, password) do
      true ->
        generate_jwt_and_render(conn, user)
      false ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Invalid username or password")
    end
  end

  defp authenticate(user, password) do
    case user do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw()
        false
      _ -> Comeonin.Bcrypt.checkpw(password, user.hash)
    end
  end

  # def logout(conn, %{}) do
  #   conn
  #   |> Guardian.Plug.logout
  #   |> render "logout.json", message: "Logged out"
  # end
end

defmodule LoudBackend.AuthController do
  use LoudBackend.Web, :controller

  alias LoudBackend.User
  import LoudBackend.ErrorHelpers, only: [translate_changeset_errors: 1]

  # plug Guardian.Plug.EnsureAuthenticated, handler: LoudBackend.GuardianErrorHandler when not action in [:new, :create]
  plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler] when action in [:logout]

  def generate_token(user) do
    with {:ok, token, full_claims} <- Guardian.encode_and_sign(user, nil, %{username: user.username, id: user.id}),
      data = %{token: token, exp: Map.get(full_claims, "exp")},
    do: {:ok, data}
  end

  defp generate_token_and_render(conn, user) do
    case generate_token(user) do
      {:ok, data} -> json(conn, data)
      {:error, reason} -> json(conn, %{error: reason})
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> Comeonin.Bcrypt.dummy_checkpw()
      _   -> Comeonin.Bcrypt.checkpw(password, user.hash)
    end
  end

  def register(conn, %{"username" => username, "password" => password}) do
    changeset = User.register_changeset(%User{}, %{username: username, password: password})

    case Repo.insert(changeset) do
      {:ok, user}         -> generate_token_and_render(conn, user)
      {:error, changeset} ->
        conn
        |> put_status(401)
        |> json(%{error: Enum.join(translate_changeset_errors(changeset), ", ")})
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    user = Repo.get_by(User, username: username)

    if authenticate(user, password) do
      generate_token_and_render(conn, user)
    else
      conn
      |> put_status(401)
      |> json(%{error: "Invalid username or password"})
    end
  end

  def logout(conn, %{"token" => token}) do
    case Guardian.revoke!(token) do
      :ok              -> json(conn, %{message: "Logged out"})
      {:error, reason} -> json(conn, %{error: reason})
    end
  end
end

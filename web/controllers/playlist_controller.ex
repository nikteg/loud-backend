defmodule LoudBackend.PlaylistController do
  use LoudBackend.Web, :controller
  use Guardian.Phoenix.Controller

  alias LoudBackend.Playlist

  # plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler] when not action in [:index, :show]
  plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler]

  def index(conn, _params, user, _claims) do
    playlists = Repo.all(assoc(user, :playlists))
    render(conn, "index.json", playlists: playlists)
  end

  def create(conn, %{"playlist" => playlist_params}, user, _claims) do
    changeset = Playlist.changeset(%Playlist{}, playlist_params)
      |> Ecto.Changeset.put_assoc(:user, user)

    case Repo.insert(changeset) do
      {:ok, playlist} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", playlist_path(conn, :show, playlist))
        |> render("show.json", playlist: playlist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoudBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user, _claims) do
    playlist = Repo.get!(Playlist, id)
    render(conn, "show.json", playlist: playlist)
  end

  def update(conn, %{"id" => id, "playlist" => playlist_params}) do
    playlist = Repo.get!(Playlist, id)
    changeset = Playlist.changeset(playlist, playlist_params)

    case Repo.update(changeset) do
      {:ok, playlist} ->
        render(conn, "show.json", playlist: playlist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoudBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    playlist = Repo.get!(Playlist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(playlist)

    send_resp(conn, :no_content, "")
  end
end

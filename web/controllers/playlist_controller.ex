defmodule LoudBackend.PlaylistController do
  use LoudBackend.Web, :controller

  alias LoudBackend.Playlist
  alias LoudBackend.Track

  # plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler] when not action in [:index, :show]
  plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler]

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    playlists = Repo.all(from(p in Playlist, where: p.user_id == ^user.id, preload: :tracks))
    render(conn, "index.json", playlists: playlists)
  end

  def create(conn, %{"playlist" => playlist_params}) do
    user = Guardian.Plug.current_resource(conn)
    track1 = Repo.get!(Track, 1)

    changeset = Playlist.changeset(%Playlist{}, playlist_params)
      |> Ecto.Changeset.put_assoc(:user, user)
      |> Ecto.Changeset.put_assoc(:tracks, [track1])

    case Repo.insert(changeset) do
      {:ok, playlist} ->
        conn
        |> put_status(201)
        |> render("show.json", playlist: playlist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoudBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    [playlist] = Repo.all(from(p in Playlist, where: p.id == ^id, preload: :tracks))
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

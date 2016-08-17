defmodule LoudBackend.PlaylistController do
  use LoudBackend.Web, :controller

  alias LoudBackend.Playlist
  alias LoudBackend.Track
  import LoudBackend.ErrorHelpers, only: [translate_changeset_errors: 1]

  # plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler] when not action in [:index, :show]
  plug Guardian.Plug.EnsureAuthenticated, [handler: LoudBackend.GuardianErrorHandler]

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    playlists = Repo.all(from(p in Playlist, where: p.user_id == ^user.id, order_by: [desc: p.id], preload: :tracks, preload: :user))
    conn |> json(playlists)
  end

  def create(conn, %{"name" => name} = params) do
    track_ids = Map.get(params, "tracks", [])
    user = Guardian.Plug.current_resource(conn)
    tracks = Repo.all(from t in Track, where: t.id in ^track_ids)

    changeset = Playlist.changeset(%Playlist{}, %{name: name})
      |> Ecto.Changeset.put_assoc(:user, user)
      |> Ecto.Changeset.put_assoc(:tracks, tracks)

    case Repo.insert(changeset) do
      {:ok, playlist} ->
        IO.inspect playlist
        conn
        |> put_status(201)
        |> json(playlist)
      {:error, changeset} ->
        conn
        |> put_status(401)
        |> json(%{error: Enum.join(translate_changeset_errors(changeset), ", ")})
    end
  end

  def show(conn, %{"id" => id}) do
    query = from p in Playlist,
      where: p.id == ^id,
      join: t in assoc(p, :tracks),
      order_by: t.id

    [playlist] = Repo.all(query)
    conn |> json(playlist)
  end

  def update(conn, %{"id" => id} = params) do
    playlist = Repo.get!(Playlist, id)

    name = Map.get(params, "name", playlist.name)
    track_ids = Map.get(params, "tracks", [])

    tracks = Repo.all(from t in Track, where: t.id in ^track_ids)
      |> Enum.map(&Ecto.Changeset.change/1)

    changeset = playlist
      |> Repo.preload(:tracks)
      |> Repo.preload(:user)
      |> Playlist.changeset(%{name: name})
      |> Ecto.Changeset.put_assoc(:tracks, tracks)

    case Repo.update(changeset) do
      {:ok, playlist} ->
        conn
        |> json(playlist)
      {:error, changeset} ->
        conn
        |> put_status(401)
        |> json(%{error: Enum.join(translate_changeset_errors(changeset), ", ")})
    end
  end

  def delete(conn, %{"id" => id}) do
    playlist = Repo.get!(Playlist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(playlist)

    conn |> json(%{message: "Playlist deleted"})
  end
end

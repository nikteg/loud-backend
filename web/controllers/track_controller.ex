defmodule LoudBackend.TrackController do
  use LoudBackend.Web, :controller

  alias LoudBackend.Track

  def index(conn, _params) do
    tracks = Repo.all(Track)

    conn
    |> json(tracks)
  end

  def create(conn, %{"track" => track_params}) do
    changeset = Track.changeset(%Track{}, track_params)

    case Repo.insert(changeset) do
      {:ok, track} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", track_path(conn, :show, track))
        |> render("show.json", track: track)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoudBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    track = Repo.get!(Track, id)
    render(conn, "show.json", track: track)
  end

  def update(conn, %{"id" => id, "track" => track_params}) do
    track = Repo.get!(Track, id)
    changeset = Track.changeset(track, track_params)

    case Repo.update(changeset) do
      {:ok, track} ->
        render(conn, "show.json", track: track)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoudBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    track = Repo.get!(Track, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(track)

    send_resp(conn, :no_content, "")
  end

  def search(conn, %{"query" => query}) do
    cond do
      query == "" ->
        conn |> json(%{error: "Empty query"})
      true ->
        query = String.replace(query, " ", "+") <> ":*"
        tracks = Repo.all(from t in Track, where: fragment("(artist || ' ' || name @@ to_tsquery(?))", ^query))

        conn |> json(tracks)
    end

  end
end

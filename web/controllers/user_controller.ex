defmodule LoudBackend.UserController do
  use LoudBackend.Web, :controller

  alias LoudBackend.User
  alias LoudBackend.Playlist
  alias LoudBackend.Track

  def show(conn, %{"username" => username}) do
    playlists_query = from p in Playlist,
      order_by: [desc: p.id],
      left_join: t in assoc(p, :tracks),
      select: %{id: p.id, name: p.name, track_count: count(t.id)},
      group_by: p.id

    query = from u in User,
      where: u.username == ^username,
      join: p in assoc(u, :playlists),
      preload: [playlists: ^playlists_query],
      limit: 1

    user = Repo.one(query)

    IO.inspect user

    conn |> json(%{id: user.id, username: user.username, playlists: user.playlists})
  end
end
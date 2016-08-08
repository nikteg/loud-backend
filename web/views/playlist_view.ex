defmodule LoudBackend.PlaylistView do
  use LoudBackend.Web, :view

  def render("index.json", %{playlists: playlists}) do
    render_many(playlists, LoudBackend.PlaylistView, "playlist.json")
  end

  def render("show.json", %{playlist: playlist}) do
    render_one(playlist, LoudBackend.PlaylistView, "playlist.json")
  end

  def render("playlist.json", %{playlist: playlist}) do
    %{name: playlist.name,
      tracks: render_many(playlist.tracks, LoudBackend.TrackView, "track.json")}
  end
end

defmodule LoudBackend.PlaylistView do
  use LoudBackend.Web, :view

  def render("index.json", %{playlists: playlists}) do
    %{data: render_many(playlists, LoudBackend.PlaylistView, "playlist.json")}
  end

  def render("show.json", %{playlist: playlist}) do
    %{data: render_one(playlist, LoudBackend.PlaylistView, "playlist.json")}
  end

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.id,
      name: playlist.name}
  end
end

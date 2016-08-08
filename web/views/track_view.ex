defmodule LoudBackend.TrackView do
  use LoudBackend.Web, :view

  def render("index.json", %{tracks: tracks}) do
    %{data: render_many(tracks, LoudBackend.TrackView, "track.json")}
  end

  def render("show.json", %{track: track}) do
    %{data: render_one(track, LoudBackend.TrackView, "track.json")}
  end

  def render("track.json", %{track: track}) do
    %{key: track.key,
      name: track.name,
      artist: track.artist,
      duration: track.duration}
  end
end

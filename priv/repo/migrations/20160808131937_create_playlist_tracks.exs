defmodule LoudBackend.Repo.Migrations.CreatePlaylistTracks do
  use Ecto.Migration

  def change do
    create table(:playlist_tracks, primary_key: false) do
      add :playlist_id, references(:playlists, on_delete: :delete_all)
      add :track_id, references(:tracks)
    end
  end
end

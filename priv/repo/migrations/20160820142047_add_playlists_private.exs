defmodule LoudBackend.Repo.Migrations.AddPlaylistsPrivate do
  use Ecto.Migration

  def change do
    alter table(:playlists) do
      add :private, :boolean, default: false
    end
  end
end

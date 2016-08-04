defmodule LoudBackend.Repo.Migrations.CreatePlaylist do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :name, :string

      timestamps()
    end

  end
end

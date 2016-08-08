defmodule LoudBackend.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :key, :string
      add :name, :string
      add :artist, :string
      add :duration, :integer

      timestamps()
    end

    create index(:tracks, [:key])
  end
end

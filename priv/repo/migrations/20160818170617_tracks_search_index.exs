defmodule LoudBackend.Repo.Migrations.TracksSearchIndex do
  use Ecto.Migration

  def up do
    execute "CREATE INDEX tsv_idx ON tracks USING gin(to_tsvector('english', artist || ' ' || name));"
  end

  def down do
    execute "DROP INDEX tracks.tsv_idx"
  end
end

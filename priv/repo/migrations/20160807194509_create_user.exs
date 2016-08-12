defmodule LoudBackend.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS \"citext\";")

    create table(:users) do
      add :username, :citext
      add :hash, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end

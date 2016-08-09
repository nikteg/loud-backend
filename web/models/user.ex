defmodule LoudBackend.User do
  use LoudBackend.Web, :model

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :hash, :string

    has_many :playlists, LoudBackend.Playlist

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password])
    |> unique_constraint(:username)
    |> validate_required([:username, :password])
    |> validate_length(:password, min: 6)
  end

  def register_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> put_change(:hash, hashed_password(params[:password]))
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end

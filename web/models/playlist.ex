defmodule LoudBackend.Playlist do
  use LoudBackend.Web, :model

  schema "playlists" do
    field :name, :string

    belongs_to :user, LoudBackend.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end

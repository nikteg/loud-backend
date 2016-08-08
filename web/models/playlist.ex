defmodule LoudBackend.Playlist do
  use LoudBackend.Web, :model

  schema "playlists" do
    field :name, :string

    belongs_to :user, LoudBackend.User
    many_to_many :tracks, LoudBackend.Track, join_through: "playlist_tracks"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> cast_assoc(:tracks)
    |> validate_required([:name])
  end
end

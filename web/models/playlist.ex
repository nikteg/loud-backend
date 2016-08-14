defmodule LoudBackend.Playlist do
  use LoudBackend.Web, :model

  @derive {Poison.Encoder, only: [:id, :name, :user, :tracks]}
  schema "playlists" do
    field :name, :string

    belongs_to :user, LoudBackend.User
    many_to_many :tracks, LoudBackend.Track, join_through: "playlist_tracks", on_replace: :delete

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

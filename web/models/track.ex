defmodule LoudBackend.Track do
  use LoudBackend.Web, :model

  @derive {Poison.Encoder, only: [:id, :key, :name, :artist, :duration]}
  schema "tracks" do
    field :key, :string
    field :name, :string
    field :artist, :string
    field :duration, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:key, :name, :artist, :duration])
    |> validate_required([:key, :name, :artist, :duration])
  end
end

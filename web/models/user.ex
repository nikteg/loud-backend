defmodule LoudBackend.User do
  use LoudBackend.Web, :model

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    # field :hash, :string

    timestamps()
  end

  def create(params) do
    changeset = changeset(%{}, params)

    if changeset.valid? do
      Repo.insert(changeset)
    else
      {:error, nil}
    end
  end

  def find_and_confirm_password(params) do
    Repo.get_by(User, params)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password])
    |> validate_required([:name, :password])
  end
end

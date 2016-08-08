defmodule LoudBackend.TrackTest do
  use LoudBackend.ModelCase

  alias LoudBackend.Track

  @valid_attrs %{artist: "some content", duration: 42, key: "some content", name: "some content", timestamps: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Track.changeset(%Track{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Track.changeset(%Track{}, @invalid_attrs)
    refute changeset.valid?
  end
end

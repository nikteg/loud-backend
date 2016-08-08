# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LoudBackend.Repo.insert!(%LoudBackend.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "j8QwmTsW-ec",
  artist: "Audien",
  name: "Rooms",
  duration: 197
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "Q_5kh91LESE",
  artist: "Biggie Smalls",
  name: "Hypnotize",
  duration: 230
}
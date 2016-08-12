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
  key: "wzt7rmsJr0w",
  artist: "Deorro Feat. MT Brudduh",
  name: "Move On",
  duration: 348
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "wQIXzB6y43U",
  artist: "Elenne",
  name: "Lack Of Shame [Electro House | NOIZE]",
  duration: 293
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "67kNvwqQ_qU",
  artist: "Gramatik",
  name: "Native Son Prequel (Jenaux Remix)",
  duration: 257
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "6cMHO5U1eY4",
  artist: "Digitalism",
  name: "Utopia",
  duration: 398
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "S_2tfFUO1sc",
  artist: "Riton",
  name: "Need Your Love (Digitalism Remix)",
  duration: 363
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "XFo2dUCRsYs",
  artist: "Noah Neiman & The Mutints",
  name: "Never Die",
  duration: 181
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "1_y5Fa_Q9h0",
  artist: "Promise Land & Luciana",
  name: "Rebound To The Beat (Official Music Video)",
  duration: 166
}

LoudBackend.Repo.insert! %LoudBackend.Track{
  key: "NE9ZfowSOUw",
  artist: "Justin Jay ft Chris Lorenzo",
  name: "Storm",
  duration: 378
}
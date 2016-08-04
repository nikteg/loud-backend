defmodule LoudBackend.Router do
  use LoudBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LoudBackend do
    pipe_through :api

    get "/", PageController, :index
    resources "/playlists", PlaylistController
  end
end

defmodule LoudBackend.Router do
  use LoudBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", LoudBackend do
    pipe_through :api

    get "/", PageController, :index
    post "/login", UserController, :login
    post "/register", UserController, :register
    resources "/playlists", PlaylistController
  end
end

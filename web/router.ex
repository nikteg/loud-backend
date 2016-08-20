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

    scope "/auth" do
      post "/register", AuthController, :register
      post "/login", AuthController, :login
      post "/logout", AuthController, :logout
    end

    get "/users/:username", UserController, :show
    resources "/playlists", PlaylistController
    resources "/tracks", TrackController
    post "/tracks/search", TrackController, :search
  end
end

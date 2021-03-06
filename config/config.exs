# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :loud_backend,
  ecto_repos: [LoudBackend.Repo]

# Configures the endpoint
config :loud_backend, LoudBackend.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "c/MW/tum44k4QcAjB5Q3UQbi7a/cwdhVmohZaptO+PpId+c6JJ+oOwtcOgmW0T7s",
  render_errors: [view: LoudBackend.ErrorView, accepts: ~w(json)],
  pubsub: [name: LoudBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Loud",
  ttl: { 30, :days },
  secret_key: "_AbBL082GKlPjoY9o-KM78PhyALavJRtZXOW7D-ZyqE",
  serializer: LoudBackend.GuardianSerializer,
  hooks: GuardianDb

config :guardian_db, GuardianDb,
  repo: LoudBackend.Repo,
  schema_name: "tokens",
  sweep_interval: 120 # 120 minutes

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

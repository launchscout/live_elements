import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_elements_testbed, LiveElementsTestbedWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Y/uVoLUDplrYfzv2jcPanL06RYD/MeulRJ08cq2UZapD/vuRkiAR7wWIzt8a/kFw",
  server: true

# In test we don't send emails.
config :live_elements_testbed, LiveElementsTestbed.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :wallaby,
  otp_app: :live_elements_testbed,
  base_url: "http://localhost:4002"
  # chromedriver: [
  #   headless: false
  # ]

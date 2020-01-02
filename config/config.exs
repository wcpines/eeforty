use Mix.Config

config :tesla, adapter: Tesla.Adapter.Hackney

config :eeforty,
  departure_date: Date.utc_today() |> Date.to_string(),
  google_maps_api_key: System.get_env("GOOGLE_MAPS_API_KEY")

config :ex_twilio,
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
  auth_token: System.get_env("TWILIO_AUTH_TOKEN")

if Mix.env() == :test do
  import_config "test.exs"
end

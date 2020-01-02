defmodule Eeforty do
  alias Eeforty.Processes.Estimator
  alias Eeforty.Processes.SessionServer, as: Sessions
  alias Eeforty.Router

  # TODO: i) implement own ETS table / itinerary storage ii) fix testing/mocking for gmaps
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Router, []),
      worker(Estimator, []),
      worker(Sessions, [])
    ]

    opts = [strategy: :one_for_one, name: Eeforty]

    Supervisor.start_link(children, opts)
  end
end

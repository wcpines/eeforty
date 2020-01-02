defmodule Eeforty.Processes.Session do
  alias Eeforty.Processes.SessionServer, as: Sessions

  def expire(itinerary) do
    GenServer.call(Sessions, {:expire, DateTime.utc_now()})
  end

  def set(token, itinerary) do
    GenServer.call(Sessions, {:set, {token, itinerary}})
  end

  def get(token) do
    GenServer.call(Sessions, {:get, {token}})
  end
end

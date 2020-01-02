defmodule Processes.Poller do
  poll = :ets.new(:notifications, [:set, :protected])

  def regesiter(number, itinerary) do
    :ets.insert_new(
      :notifications,
      {"9252553785", [origin: "Santa Barbara", destination: "Carpinteria"]}
    )
  end
end

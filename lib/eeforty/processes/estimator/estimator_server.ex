defmodule Eeforty.Processes.EstimatorServer do
  import Eeforty.Processes.Estimator

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_when_to_leave(itinerary) do
    GenServer.call(__MODULE__, {:get_when_to_leave, itinerary})
  end

  def init(_opts) do
    {:ok, []}
  end

  def handle_call({:get_when_to_leave, itinerary}, _from, _empty_map) do
    itinerary
    |> get_estimate()
    |> compare_times()
  end
end

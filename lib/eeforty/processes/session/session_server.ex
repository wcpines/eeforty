defmodule Eeforty.Processes.SessionServer do
  use GenServer

  def start_link do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    state =
      :ets.new(:user_sessions, [:named_table, :public, read_concurrency: true])

    {:ok, state}
  end

  def handle_call({:expire, expiry}, _from, _empty_map) do
    "PENDING"
  end

  def handle_call({:set, {token, itinerary}}, _from, _empty_map) do
    :ets.insert_new(:user_sessions, {token, itinerary})
    |> case do
      true ->
        {:reply, "Data stored", itinerary}

      false ->
        {:reply, "Data already exists"}
    end
  end

  def handle_call({:get, {token}}, _from, _empty_map) do
    :ets.lookup(:user_sessions, token)
    |> case do
      [] ->
        {:reply, "No itinerary for given token", token}

      {token, itinerary} ->
        {:reply, itinerary}
    end
  end
end

defmodule Eeforty.Processes.Sesh do
  # https://elixirschool.com/en/lessons/specifics/ets/
  def start_link do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def store_user(itinerary) do
    GenServer.call(__MODULE__, {:store_user, itinerary})
  end

  ## Client

  # def log(uid) do
  #   case :ets.update_counter(@tab, uid, {2, 1}, {uid, 0}) do
  #     count when count > @max_per_minute -> {:error, :rate_limited}
  #     _count -> :ok
  #   end
  # end

  ## Server
  def init(_) do
    :ets.new(:user_sessions, [:named_table, :protected, read_concurrency: true])
    {:ok, []}
  end

  # def handle_info(:sweep, state) do
  #   Logger.debug("Sweeping requests")
  #   :ets.delete_all_objects(@tab)
  #   schedule_sweep()
  #   {:noreply, state}
  # end

  # defp schedule_sweep do
  #   Process.send_after(self(), :sweep, @sweep_after)
  # end
end

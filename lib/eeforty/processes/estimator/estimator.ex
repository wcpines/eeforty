defmodule Eeforty.Processes.Estimator do
  import Eeforty.Utils
  alias Eeforty.Adapters.GoogleMaps

  @google_maps Application.get_env(:eeforty, :google_maps, GoogleMaps)

  def get_estimate([origin, _, _, _]) when is_empty(origin) do
    {:error, "Missing required param: Origin"}
  end

  def get_estimate([_, destination, _, _]) when is_empty(destination) do
    {:error, "Missing required param: Destination"}
  end

  def get_estimate([origin, destination, departure_datetime, commute_threshold]) do
    gmaps_result = @google_maps.request(origin, destination, departure_datetime)

    case gmaps_result do
      {:ok, estimate} ->
        [estimate, commute_threshold]

      {:error, _msg} ->
        gmaps_result
    end
  end

  def compare_times([estimate, commute_threshold]) do
    case estimate <= commute_threshold do
      true ->
        {:reply, "now", []}

      _ ->
        {:reply, "later", []}
    end
  end

  def compare_times({:error, msg}) do
    {:reply, {:error, msg}, []}
  end
end

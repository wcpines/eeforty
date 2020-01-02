defmodule Eeforty.Utils.TimeHandler do
  @departure_date Application.get_env(:eeforty, :departure_date, "2020-01-01")

  @spec convert_itinerary(map) :: map
  def convert_itinerary(itinerary) do
    [
      commute_period,
      commute_start,
      commute_threshold
    ] = get_times(itinerary)

    Map.merge(
      itinerary,
      %{
        "commute_period" => commute_period,
        "commute_start" => commute_start,
        "commute_threshold" => commute_threshold,
        "departure_unix" => departure_unix_time(commute_start),
        "commute_end" => Time.add(commute_start, commute_period)
      }
    )
  end

  @spec commute_window_strings(integer(), integer()) :: list(String.t())
  def commute_window_strings(departure_unix, period) do
    period_end_unix = departure_unix + period

    {:ok, t1} = DateTime.from_unix(departure_unix)
    {:ok, t2} = DateTime.from_unix(period_end_unix)

    [DateTime.to_iso8601(t1), DateTime.to_iso8601(t2)]
  end

  defp get_times(itinerary) do
    [
      get_commute_period(itinerary),
      get_start_time(itinerary),
      get_commute_threshold(itinerary)
    ]
  end

  defp get_commute_period(itinerary) do
    itinerary
    |> Map.get("commute_period")
    |> String.to_integer()
    |> Kernel.*(3600)
  end

  defp get_start_time(itinerary) do
    itinerary
    |> Map.get("commute_start")
    |> Kernel.<>(":00")
    |> Time.from_iso8601!()
  end

  defp get_commute_threshold(itinerary) do
    [hrs, min] =
      [itinerary["travel_hours"], itinerary["travel_minutes"]]
      |> Enum.map(&String.to_integer/1)

    hrs * 3600 + min * 60
  end

  # TODO: Handle time diff/timezone and use traffic data

  defp departure_unix_time(start_time) do
    @departure_date
    |> Kernel.<>("T#{start_time}Z")
    |> DateTime.from_iso8601()
    |> elem(1)
    |> DateTime.to_unix()
  end
end

defmodule Eeforty.Utils.Misc do
  alias Eeforty.Utils.TimeHandler

  def present_itinerary(itinerary) do
    window =
      TimeHandler.commute_window_strings(
        itinerary["departure_unix"],
        itinerary["commute_period"]
      )
      |> Enum.join(" - ")

    """
    <b>Origin:</b> #{itinerary["origin"]},<br>
    <b>Destination:</b> #{itinerary["destination"]},<br>
    <b>Desired max commute time:</b> #{itinerary["commute_threshold"]},<br>
    <b>Commute window:</b> #{window}<br>
    <b>Provided Phone Number:</b> #{itinerary["phone"]}
    """
  end

  def generate_session_key(itinerary) do
    itinerary
    |> Map.values()
    |> Enum.map(&to_string(&1))
    |> Enum.join()
    |> :erlang.md5()
    |> Base.encode16()
  end
end

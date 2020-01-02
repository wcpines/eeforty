defmodule Eeforty.Utils.TimeHandlerTest do
  use ExUnit.Case
  alias Eeforty.Utils.TimeHandler

  @datetime_unix 1_577_869_200

  @itinerary %{
    "commute_period" => "1",
    "commute_start" => "09:00",
    "destination" => "Santa Barbara, CA",
    "origin" => "Carpinteria, CA",
    "travel_hours" => "0",
    "travel_minutes" => "30"
  }

  describe "The time handler adds fields for integer seconds and Time objects to the itinerary" do
    test "TimeHandler.convert_itinerary/1" do
      assert TimeHandler.convert_itinerary(@itinerary) == %{
               "commute_end" => ~T[10:00:00.000000],
               "commute_period" => 3600,
               "commute_start" => ~T[09:00:00],
               "commute_threshold" => 1800,
               "departure_unix" => @datetime_unix,
               "destination" => "Santa Barbara, CA",
               "origin" => "Carpinteria, CA",
               "travel_hours" => "0",
               "travel_minutes" => "30"
             }
    end
  end
end

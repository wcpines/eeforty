defmodule Eeforty.Adapters.GoogleMapsTest do
  use ExUnit.Case
  alias Eeforty.Adapters.GoogleMaps
  alias Eeforty.Support.GoogleResponses
  alias Tesla.Mock

  describe "GoogleMaps.request/3" do
    test "a valid response" do
      Tesla.Mock.mock(fn %{
                           method: :get,
                           url:
                             "https://maps.googleapis.com/maps/api/distancematrix/json"
                         } ->
        {:ok, GoogleResponses.success()}
      end)

      assert {:ok, duration} = GoogleMaps.request("Santa Barbara", "San Francisco", "now")
      assert is_integer(duration)
    end
  end
end

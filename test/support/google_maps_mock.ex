defmodule Eeforty.Support.GoogleMapsMock do
  def request(_origin, _destination, _departure_datetime, "success") do
    {:ok, 1800}
  end

  def request(_origin, _destination, _departure_datetime, "error") do
    {:error,
     "It appears there is no valid route between the destination and origin you chose."}
  end
end

defmodule Eeforty.Adapters.GoogleMaps do
  require Logger

  @api_key Application.get_env(:eeforty, :google_maps_api_key)
  @maps_api_base_url "https://maps.googleapis.com/maps/api/distancematrix/json"

  @spec request(String.t(), String.t(), String.t() | integer()) ::
          {:error, String.t()} | {:ok, integer()}
  def request(origin, destination, departure_datetime \\ "now") do
    {:ok, resp} = call_api(origin, destination, departure_datetime)
    handle_response(resp.body)
  end

  defp call_api(origin, destination, departure_datetime) do
    Tesla.get(@maps_api_base_url,
      query: [
        origins: origin,
        destinations: destination,
        departure_time: departure_datetime,
        key: @api_key
      ]
    )
  end

  defp handle_response(json_body) do
    json_body
    |> Jason.decode!()
    |> dig_structure
    |> get_result
  end

  defp get_result({:error, bad_status, msg}) do
    {:error, "Error:\n\n#{bad_status} \n\n #{msg}"}
  end

  defp get_result({"NOT_FOUND", nil}) do
    {:error,
     "Sorry. It looks like the origin or destination specified couldn't be found. Try something else."}
  end

  defp get_result({"ZERO_RESULTS", nil}) do
    {:error,
     "It appears there is no valid route between the destination and origin you chose."}
  end

  defp get_result({status, nil}) do
    Logger.warn("Bad Request:\n" <> inspect(status))
    {:error, "Hmmm. Something went wrong. Try again? "}
  end

  defp get_result({"OK", duration}) do
    {:ok, duration}
  end

  defp dig_structure(%{"status" => "OK"} = gmaps_data) do
    structure =
      gmaps_data
      |> Map.get("rows")
      |> Enum.at(0)
      |> Map.get("elements")
      |> Enum.at(0)

    status = Map.get(structure, "status")
    duration = Kernel.get_in(structure, ["duration", "value"])
    {status, duration}
  end

  defp dig_structure(%{"status" => bad_status, "error_message" => msg} = result) do
    Logger.warn("Bad Request:\n" <> inspect(result))
    {:error, bad_status, msg}
  end
end

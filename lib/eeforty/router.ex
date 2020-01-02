defmodule Eeforty.Router do
  use Plug.Router

  import Plug.Conn

  alias Eeforty.Processes.Session
  alias Eeforty.Utils.TimeHandler
  alias Eeforty.Processes.Estimator
  import Eeforty.Utils
  # alias Eeforty.Adapters.Twilio

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    accept: ["application/json", "text/*"],
    json_decoder: Jason
  )

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [])
  end

  get "/" do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> send_file(200, "lib/eeforty/templates/home.eex")
  end

  post "/go" do
    itinerary = TimeHandler.convert_itinerary(conn.body_params)
    token = generate_session_key(itinerary)

    conn
    |> send_resp(
      200,
      EEx.eval_file("lib/eeforty/templates/text.eex",
        itinerary: "hi",
        itinerary: itinerary |> present_itinerary,
        token: token
      )
    )
  end

  # post "/go" do
  #   itinerary = TimeHandler.convert_itinerary(conn.body_params)

  #   case itinerary["commute_threshold"] > itinerary["commute_period"] do
  #     true ->
  #       conn
  #       |> send_resp(
  #         200,
  #         EEx.eval_file("lib/eeforty/templates/nope.eex",
  #           error_message: "Commute window less than max commute time"
  #         )
  #       )

  #     _ ->
  #       [
  #         itinerary["origin"],
  #         itinerary["destination"],
  #         itinerary["departure_unix"],
  #         itinerary["commute_threshold"]
  #       ]
  #       |> Estimator.get_when_to_leave()
  #       |> case do
  #         "now" ->
  #           conn
  #           |> send_file(200, "lib/eeforty/templates/now.eex")

  #         "later" ->
  #           require IEx; IEx.pry
  #           conn
  #           |> send_resp(
  #             200,
  #             EEx.eval_file("lib/eeforty/templates/text.eex",
  #               itinerary: "#{itinerary}"
  #             )
  #           )

  #         {:error, msg} ->
  #           conn
  #           |> send_resp(
  #             200,
  #             EEx.eval_file("lib/eeforty/templates/nope.eex", error_message: msg)
  #           )
  #       end
  #   end
  # end

  post "/text" do
    require IEx
    IEx.pry()
    %{"token" => token} = conn.body_params
    # case Twilio.verify_recipient(number) do
    #   {:ok, success_msg} ->
    #     Poller.register(number, itinerary)
    #     send_resp(conn, 200, success_msg)

    #   {:error, failure_msg} ->
    #     send_resp(conn, 400, failure_msg)
    # end
  end

  # post "/reply" do
  #   user_reply = conn.body_params["Body"]
  #   user_number = conn.body_params["From"]

  #   user_reply
  #   |> String.downcase()
  #   |> String.trim()
  #   |> case do
  #     "abort" ->
  #       Twilio.cancel(user_number)

  #     _ ->
  #       Twilio.wat(user_number)
  #   end

  #   send_resp(conn, 200, "canceled")
  # end

  match _ do
    send_resp(
      conn,
      501,
      "Hmmm... Looks like you've found yourself in some new territory." <>
        "\nWell, we haven't built anything for this yet.\n\n" <>
        "Good on you for exploring, though!"
    )
  end
end

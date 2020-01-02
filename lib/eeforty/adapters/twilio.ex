defmodule Eeforty.Adapters.Twilio do
  alias ExTwilio

  def text_to_leave(number) do
    ExTwilio.Message.create(
      from: System.get_env("TWILIO_SENDER_NUMBER"),
      to: number,
      body: alerts()
    )
  end

  def verify_recipient(number) do
    case validate_number(number) do
      {:ok, number} ->
        send_message(
          number,
          "Just verifying we got your number. We'll alert you when it's time to leave.
          If you want to cancel alerts, reply with 'abort'"
        )

        {:ok, "Verification text sent to the number you provided: #{number}"}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def cancel(number) do
    send_message(number, "Notifications canceled")
  end

  def wat(number) do
    send_message(number, "Wat?")
  end

  defp send_message(number, message) do
    ExTwilio.Message.create(
      from: System.get_env("TWILIO_SENDER_NUMBER"),
      to: number,
      body: message
    )
  end

  defp alerts do
    Enum.random([
      "Time to hit the road!",
      "Let's get the commute party started. Zoom zoom!",
      "Thanks for being so patient. Your optimal commute departure time starts now!",
      "GOGOGOGOGOGO MOOMOOMOO"
    ])
  end

  defp validate_number(number) do
    number
    |> String.replace(~r/[\D]/, "")
    |> String.match?(~r/\A\d{10}\Z/)
    |> case do
      true -> {:ok, number}
      _ -> {:error, "Invalid recipient number provided"}
    end
  end
end

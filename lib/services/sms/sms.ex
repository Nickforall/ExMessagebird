defmodule ExMessagebird.SMS do
  @moduledoc """
  Programmable SMS

  https://developers.messagebird.com/api/sms-messaging
  """

  @doc """
  Sends an SMS to the recipient
  """
  @spec send_text_message(String.t(), String.t()) ::
          {:error, HTTPoison.Error.t() | map} | {:ok, any}
  def send_text_message(recipient, message) do
    with {:ok, %HTTPoison.Response{body: body}} <-
           ExMessagebird.post("messages", %{
             recipients: recipient,
             body: message,
             originator: ExMessagebird.originator()
           }),
         {:ok, body} <- parse_json_body(body),
         {:ok, response} <- ExMessagebird.SMS.Message.from_response(body) do
      {:ok, response}
    else
      {:error, :invalid_response} -> {:error, "Invalid response returned from Messagebird API"}
      error -> error
    end
  end

  defp parse_json_body(body) do
    case Poison.decode(body) do
      {:ok, map} -> {:ok, map}
      {:error, _} -> {:error, :invalid_response}
    end
  end
end

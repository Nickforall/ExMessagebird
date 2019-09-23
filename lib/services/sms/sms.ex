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
         {:ok, response} <- ExMessagebird.SMS.Message.from_response(body) do
      {:ok, response}
    else
      {:error, :invalid_response} -> {:error, "Invalid response returned from Messagebird API"}
      error -> error
    end
  end
end

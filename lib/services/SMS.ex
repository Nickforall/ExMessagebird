defmodule ExMessagebird.SMS do
  @doc """
  Sends an SMS to the recipient
  """
  @spec send_text_message(String.t(), String.t()) :: {:error, HTTPoison.Error.t()} | {:ok, any}
  def send_text_message(recipient, message) do
    with {:ok, %HTTPoison.Response{body: body}} <-
           ExMessagebird.post("messages", %{
             recipients: recipient,
             body: message,
             originator: ExMessagebird.originator()
           }) do
      {:ok, body}
    else
      error -> error
    end
  end
end

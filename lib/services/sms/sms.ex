defmodule ExMessagebird.SMS do
  @moduledoc """
  Programmable SMS

  https://developers.messagebird.com/api/sms-messaging
  """

  @backend Application.get_env(:ex_messagebird, :backend, ExMessagebird.Backend.Messagebird)

  @doc """
  Sends an SMS to the recipient

  Possible options:
    `:originator` Overwrites the default originator set in config
    `:scheduledDatetime` The scheduled date and time of the message in RFC3339 format (Y-m-dTH:i:sP)
    `:validity`   The amount of seconds that the message is valid. If a message is not delivered within this time, the message will be discarded.
    `:datacoding` The datacoding used can be `plain` (GSM 03.38 characters only), `unicode` (contains non-GSM 03.38 characters)
                  or `auto`, we will then set unicode or plain depending on the body content.
    `:backend`    Override configured backend
  """
  def send_text_message(recipient, message, options \\ %{}) do
    defaults = %{
      recipients: recipient,
      body: message,
      originator: ExMessagebird.originator()
    }

    options = Map.merge(defaults, options)
    backend = Map.get(options, :backend, @backend)

    with {:ok, response} <- backend.send_message(options) do
      {:ok, response}
    else
      {:error, :invalid_response} -> {:error, "Invalid response returned from Messagebird API"}
      error -> error
    end
  end
end

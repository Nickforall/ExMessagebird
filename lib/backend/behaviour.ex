defmodule ExMessagebird.Backend.Behaviour do
  @moduledoc """
  Implement this behaviour for custom backends
  """

  @type send_message_options :: %{
          originator: String.t(),
          scheduledDateTime: String.t(),
          validity: integer,
          datacoding: :plain | :auto | :unicode,
          body: String.t(),
          recipients: String.t()
        }

  @callback send_message(__MODULE__.send_message_options()) ::
              {:ok, ExMessagebird.SMS.Message.t()} | {:error, :invalid_response}
end

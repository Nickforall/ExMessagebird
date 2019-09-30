defmodule ExMessagebird.Backend.InMemory do
  @moduledoc """
  A Messagebird back-end that saves messages in memory for debugging purposes
  """

  @behaviour ExMessagebird.Backend.Behaviour

  def send_message(options) do
    {:ok, options}
  end
end

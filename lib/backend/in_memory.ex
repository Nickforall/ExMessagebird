defmodule ExMessagebird.Backend.InMemory do
  @moduledoc """
  A Messagebird back-end that saves messages in memory for debugging purposes.
  """

  @behaviour ExMessagebird.Backend.Behaviour
  @server ExMessagebird.Backend.InMemory.Server

  def send_message(options) when is_map(options) do
    reply = GenServer.call(@server, {:push, options})
    {:ok, reply}
  end

  @doc """
  Lists all the messages sent to the InMemory store ordered by descending index
  """
  def list_sent_messages do
    GenServer.call(@server, :list)
    |> Enum.sort(fn %{index: a}, %{index: b} -> a >= b end)
  end
end

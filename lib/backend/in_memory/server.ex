defmodule ExMessagebird.Backend.InMemory.Server do
  @moduledoc false

  use GenServer

  def start_link(init, options \\ []) do
    GenServer.start_link(__MODULE__, init, options)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:push, message}, _from, state) do
    pushed = Map.merge(message, %{index: length(state)})
    {:reply, pushed, [pushed | state]}
  end
end

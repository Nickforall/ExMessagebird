defmodule ExMessagebird do
  @moduledoc """
  Documentation for ExMessagebird.
  """

  use Application

  @doc """
  Returns the url of the MessageBird API server
  """
  def base_url do
    Application.get_env(:ex_messagebird, :url, "https://rest.messagebird.com/")
  end

  @doc """
  Returns the configured originator string used for sending SMS messages
  """
  def originator do
    originator = Application.get_env(:ex_messagebird, :originator)

    if is_nil(originator) do
      raise "Invalid config: `:ex_messagebird` > `:originator` is nil"
    end

    originator
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(
        ExMessagebird.Backend.InMemory.Server,
        [[], [name: ExMessagebird.Backend.InMemory.Server]]
      )
    ]

    opts = [strategy: :one_for_one, name: ExMessagebird.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

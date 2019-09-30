defmodule ExMessagebird do
  @moduledoc """
  Documentation for ExMessagebird.
  """

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
end

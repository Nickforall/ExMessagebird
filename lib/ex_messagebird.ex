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

  @doc """
  Makes a POST request to the messagebird API and uses the configured token as means of authentication
  """
  def post(endpoint, data) do
    HTTPoison.post("#{base_url()}#{endpoint}", URI.encode_query(data),
      Authorization: auth_header(),
      Accept: "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    )
  end

  defp token do
    token = Application.get_env(:ex_messagebird, :token)

    if is_nil(token) do
      raise "Invalid config: `:ex_messagebird` > `:token` is nil"
    end

    token
  end

  defp auth_header do
    "AccessKey #{token()}"
  end
end

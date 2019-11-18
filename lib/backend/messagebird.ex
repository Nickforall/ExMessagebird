defmodule ExMessagebird.Backend.Messagebird do
  @moduledoc """
  The default backend that calls the messagebird API
  """

  @behaviour ExMessagebird.Backend.Behaviour

  def token do
    token = Application.get_env(:ex_messagebird, :token)

    if is_nil(token) do
      raise "Invalid config: `:ex_messagebird` > `:token` is nil"
    end

    token
  end

  def auth_header do
    "AccessKey #{token()}"
  end

  @doc """
  Makes a POST request to the messagebird API and uses the configured token as means of authentication
  """
  @spec post(String.t(), any) :: {:ok, map} | {:error, :invalid_response}
  def post(endpoint, data) do
    with {:ok, response} <-
           HTTPoison.post("#{ExMessagebird.base_url()}#{endpoint}", URI.encode_query(data),
             Authorization: auth_header(),
             Accept: "application/json",
             "Content-Type": "application/x-www-form-urlencoded"
           ),
         {:ok, response} <- parse_json_body(response) do
      {:ok, response}
    else
      _ -> {:error, :invalid_response}
    end
  end

  defp parse_json_body(%HTTPoison.Response{body: body}) do
    case Jason.decode(body) do
      {:ok, map} -> {:ok, map}
      _ -> {:error, :invalid_response}
    end
  end

  def send_message(options) do
    case post("messages", options) do
      {:ok, response} -> from_response(response)
      error -> error
    end
  end

  defp from_response(response) do
    case ExMessagebird.SMS.Message.from_response(response) do
      {:ok, response} -> {:ok, response}
      {:error, _} -> ExMessagebird.Error.from_response(response)
    end
  end
end

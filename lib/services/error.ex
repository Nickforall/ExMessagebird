defmodule ExMessagebird.Error do
  defstruct code: nil, description: nil, parameter: nil

  @type t :: %__MODULE__{
          code: __MODULE__.code(),
          description: String.t(),
          parameter: String.t()
        }

  @doc """
  Creates an Error struct from the JSON error object returned by the messagebird API.

  Example JSON:
  ```
  {
    "code": 2,
    "description": "Request not allowed (incorrect access_key)",
    "parameter": "access_key"
  }
  ```
  """
  def from_json(%{
        "code" => code,
        "description" => description,
        "parameter" => parameter
      }) do
    {:ok,
     %__MODULE__{
       code: code_to_atom(code),
       description: description,
       parameter: parameter
     }}
  end

  def from_json(_), do: {:error, :invalid_response}

  @doc """
  Returns a list of Error structs from a Messagebird API error response.

  Example: https://developers.messagebird.com/api#api-errors
  """
  def from_response(%{"errors" => list}) when is_list(list) do
    {:ok,
     list
     |> Enum.map(fn x ->
       case from_json(x) do
         {:ok, struct} -> struct
         _ -> nil
       end
     end)
     |> Enum.filter(fn x -> not is_nil(x) end)}
  end

  def from_response(_), do: {:error, :invalid_response}

  @type code ::
          :request_not_allowed
          | :missing_params
          | :invalid_params
          | :not_found
          | :bad_request
          | :not_enough_balance
          | :api_not_found
          | :internal_error
          | :unknown

  @doc """
  Converts an error code to an atom

  ## Exanples

    iex> ExMessagebird.Error.code_to_atom(2)
    :request_not_allowed

    iex> ExMessagebird.Error.code_to_atom(9)
    :missing_params

    iex> ExMessagebird.Error.code_to_atom(10)
    :invalid_params

    iex> ExMessagebird.Error.code_to_atom(20)
    :not_found

    iex> ExMessagebird.Error.code_to_atom(21)
    :bad_request

    iex> ExMessagebird.Error.code_to_atom(25)
    :not_enough_balance

    iex> ExMessagebird.Error.code_to_atom(98)
    :api_not_found

    iex> ExMessagebird.Error.code_to_atom(99)
    :internal_error

    iex> ExMessagebird.Error.code_to_atom(101)
    :unknown

  """
  def code_to_atom(integer) do
    case integer do
      2 ->
        :request_not_allowed

      9 ->
        :missing_params

      10 ->
        :invalid_params

      20 ->
        :not_found

      21 ->
        :bad_request

      25 ->
        :not_enough_balance

      98 ->
        :api_not_found

      99 ->
        :internal_error

      _ ->
        :unknown
    end
  end
end

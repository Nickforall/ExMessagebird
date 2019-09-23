defmodule ExMessagebird.SMS.Message do
  defstruct [
    :id,
    :href,
    :direction,
    :type,
    :originator,
    :body,
    :validity,
    :gateway,
    :datacoding,
    :mclass,
    :scheduled_datetime,
    :created_datetime
  ]

  alias __MODULE__

  @doc """
  Generates a message struct from the json object returned by the programmable SMS API
  """
  def from_response(%{
        "id" => id,
        "href" => href,
        "direction" => direction,
        "type" => type,
        "originator" => originator,
        "body" => body,
        "validity" => validity,
        "gateway" => gateway,
        "datacoding" => datacoding,
        "mclass" => mclass,
        "scheduledDatetime" => scheduled_datetime,
        "createdDatetime" => created_datetime
      }) do
    {:ok,
     %Message{
       id: id,
       href: href,
       direction: direction,
       type: type,
       originator: originator,
       body: body,
       validity: validity,
       gateway: gateway,
       datacoding: datacoding,
       mclass: mclass,
       scheduled_datetime: scheduled_datetime,
       created_datetime: created_datetime
     }}
  end

  def from_response(_) do
    {:error, :invalid_response}
  end
end

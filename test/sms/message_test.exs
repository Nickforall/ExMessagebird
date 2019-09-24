defmodule ExMessagebird.SMS.MessageTest do
  # Use the module
  use ExUnit.Case, async: true

  describe "from_response/1" do
    setup do
      data =
        File.read!("test/support/message.json")
        |> Jason.decode!()

      %{data: data}
    end

    test "parses valid message correctly", %{data: data} do
      assert {:ok, message_object} = ExMessagebird.SMS.Message.from_response(data)
    end

    test "returns error tuple for invalid message correctly" do
      assert {:error, :invalid_response} =
               ExMessagebird.SMS.Message.from_response(%{
                 "id" => "bogus",
                 "type" => "pocus"
               })
    end
  end
end

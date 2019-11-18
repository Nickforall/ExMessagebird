defmodule ExMessagebird.ErrorTest do
  use ExUnit.Case, async: true
  doctest ExMessagebird.Error

  describe "from_response/1" do
    setup do
      data =
        File.read!("test/support/errors.json")
        |> Jason.decode!()

      %{data: data}
    end

    test "parses valid error correctly", %{data: data} do
      assert {:ok, message_object} = ExMessagebird.Error.from_response(data)
    end

    test "returns error tuple for error message correctly" do
      assert {:error, :invalid_response} =
               ExMessagebird.Error.from_response(%{
                 "error" => "test"
               })
    end
  end
end

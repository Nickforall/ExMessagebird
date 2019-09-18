defmodule ExMessagebirdTest do
  use ExUnit.Case
  doctest ExMessagebird

  test "greets the world" do
    assert ExMessagebird.hello() == :world
  end
end

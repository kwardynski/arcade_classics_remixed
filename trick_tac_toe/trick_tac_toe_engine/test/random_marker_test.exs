defmodule TrickTacToeEngine.RandomMarkerTest do
  use ExUnit.Case, async: true

  alias TrickTacToeEngine.RandomMarker

  describe "get/1" do
    test "returns either :x or :o if given either :x or :o" do
      valid_markers = [:x, :o]

      {:ok, marker} = RandomMarker.get(:x)
      assert marker in valid_markers

      {:ok, marker} = RandomMarker.get(:o)
      assert marker in valid_markers
    end

    test "returns an error tuple if given in improper input" do
      assert {:error, :invalid_seed} = RandomMarker.get(1)
      assert {:error, :invalid_seed} = RandomMarker.get("invalid_seed")
      assert {:error, :invalid_seed} = RandomMarker.get(:invalid_seed)
    end
  end
end

defmodule TrickTacToeEngine.CoordinateTest do
  use ExUnit.Case, async: true

  alias TrickTacToeEngine.Coordinate

  describe "new/1" do
    test "returns an :ok tuple if given valid coordinates" do
      {:ok, coordinate} = Coordinate.new(1, 3)
      assert coordinate.row == 1
      assert coordinate.col == 3
    end

    test "returns an :error tuple if row is invalid" do
      assert {:error, :invalid_coordinates} = Coordinate.new(0, 2)
      assert {:error, :invalid_coordinates} = Coordinate.new(4, 2)
    end

    test "returns an :error tuple if col is invalid" do
      assert {:error, :invalid_coordinates} = Coordinate.new(2, 0)
      assert {:error, :invalid_coordinates} = Coordinate.new(2, 4)
    end
  end
end

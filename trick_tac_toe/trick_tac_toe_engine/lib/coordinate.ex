defmodule TrickTacToeEngine.Coordinate do
  @moduledoc """
  Simple representation of a coordinate within the board
  """

  alias __MODULE__

  @enforce_keys [:row, :col]
  @board_range 1..3

  defstruct [:row, :col]

  @doc """
  Creates a new coordinate struct, ensuring the guess coordinates are within the
  bounds of the game board
  """
  def new(row, col) when row in (@board_range) and col in (@board_range) do
    {:ok, %Coordinate{row: row, col: col}}
  end

  def new(_row, _col) do
    {:error, :invalid_coordinate}
  end
end

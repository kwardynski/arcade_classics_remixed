defmodule DongEngine.Physics.Collisions do
  @moduledoc """
  Module used to handle collision logic:
    - Ball and Board
    - Ball and Paddle
    - Paddle and Board
  """

  alias DongEngine.GameObjects.Ball
  alias DongEngine.GameObjects.Board

  # Detect collisions between a Ball and Board
  # Returns an atom representing which edge of the board the ball has collided with,
  # or :none if no collision detected
  def detect(%Ball{} = ball, %Board{} = board) do
    cond do
      Ball.calculate_edge(ball, :top) <= 0 -> :top
      Ball.calculate_edge(ball, :bottom) >= board.height -> :bottom
      Ball.calculate_edge(ball, :left) <= 0 -> :left
      Ball.calculate_edge(ball, :right) >= board.width -> :right
      true -> :none
    end
  end

  # Catch-all for invalid types
  def detect(_invalid_object_1, _invalid_object_2) do
    {:error, "invalid objects"}
  end



end

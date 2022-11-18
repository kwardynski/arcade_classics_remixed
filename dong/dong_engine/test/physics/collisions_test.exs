defmodule DongEngine.Physics.CollisionsTest do
  use ExUnit.Case, async: true
  doctest DongEngine.Physics.Collisions

  alias DongEngine.GameObjects.Ball
  alias DongEngine.GameObjects.Board
  alias DongEngine.Physics.Collisions
  alias DongEngine.Physics.Vector


  describe "detect(%Ball{}, %Board{})" do
    setup do
      %{
        board: %Board{height: 100, width: 100},
        ball_radius: 12,
        ball_velocity: %Vector{x: 0, y: 0}
      }
    end

    test "detects collision at top edge", fixture do
      position = %Vector{x: 50, y: 12}
      ball = %Ball{position: position, velocity: fixture.ball_velocity, radius: fixture.ball_radius}
      assert :top == Collisions.detect(ball, fixture.board)
    end

    test "detects collision at bottom edge", fixture do
      position = %Vector{x: 50, y: 88}
      ball = %Ball{position: position, velocity: fixture.ball_velocity, radius: fixture.ball_radius}
      assert :bottom == Collisions.detect(ball, fixture.board)
    end

    test "detects collision at left edge", fixture do
      position = %Vector{x: 12, y: 50}
      ball = %Ball{position: position, velocity: fixture.ball_velocity, radius: fixture.ball_radius}
      assert :left == Collisions.detect(ball, fixture.board)
    end

    test "detects collision at right edge", fixture do
      position = %Vector{x: 88, y: 50}
      ball = %Ball{position: position, velocity: fixture.ball_velocity, radius: fixture.ball_radius}
      assert :right == Collisions.detect(ball, fixture.board)
    end

    test "returns :none for no collision", fixture do
      position = %Vector{x: 50, y: 50}
      ball = %Ball{position: position, velocity: fixture.ball_velocity, radius: fixture.ball_radius}
      assert :none == Collisions.detect(ball, fixture.board)
    end
  end

  test "detect/2 returns  error tuple for invalid objects" do
    {:error, msg} = Collisions.detect(12, 12)
    assert msg == "invalid objects"
  end


end

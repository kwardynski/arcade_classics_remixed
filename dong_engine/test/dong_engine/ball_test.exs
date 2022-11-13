defmodule DongEngine.BallTest do
  use ExUnit.Case, async: true
  doctest DongEngine.Ball

  alias DongEngine.Ball
  alias DongEngine.Physics.Vector

  describe "calculate_edge/2" do
    setup do
      %{
        ball: %Ball{
          position: %Vector{x: 420, y: 69},
          velocity: %Vector{x: 0, y: 0},
          radius: 12
        }
      }
    end

    test "appropriately calculated edges", %{ball: ball} do
      assert 57 == Ball.calculate_edge(ball, :top)
      assert 81 == Ball.calculate_edge(ball, :bottom)
      assert 408 == Ball.calculate_edge(ball, :left)
      assert 432 == Ball.calculate_edge(ball, :right)
    end

    test "returns error on invalid edge", %{ball: ball} do
      assert {:error, "Invalid Edge"} == Ball.calculate_edge(ball, :invalid_edge)
    end
  end

  describe "check_collision/2" do
    setup do
      %{
        board: %Vector{x: 100, y: 100},
        velocity: %Vector{x: 0, y: 0},
        radius: 12
      }
    end

    test "collision at top", fixture do
      ball = %Ball{position: %Vector{x: 50, y: 8}, velocity: fixture.velocity, radius: fixture.radius}
      assert Ball.check_collision(ball, fixture.board) == :top
    end

    test "collision at bottom", fixture do
      ball = %Ball{position: %Vector{x: 50, y: 92}, velocity: fixture.velocity, radius: fixture.radius}
      assert Ball.check_collision(ball, fixture.board) == :bottom
    end

    test "collision at left", fixture do
      ball = %Ball{position: %Vector{x: 8, y: 50}, velocity: fixture.velocity, radius: fixture.radius}
      assert Ball.check_collision(ball, fixture.board) == :left
    end

    test "collision at right", fixture do
      ball = %Ball{position: %Vector{x: 92, y: 50}, velocity: fixture.velocity, radius: fixture.radius}
      assert Ball.check_collision(ball, fixture.board) == :right
    end

    test "no collision", fixture do
      ball = %Ball{position: %Vector{x: 50, y: 50}, velocity: fixture.velocity, radius: fixture.radius}
      assert Ball.check_collision(ball, fixture.board) == :none
    end
  end

  test "move/1 returns struct with updated position" do
    position = %Vector{x: 420, y: 69}
    velocity = %Vector{x: -20, y: 1}
    radius = 12

    moved_ball =
      %Ball{position: position, velocity: velocity, radius: radius}
      |> Ball.move

    assert moved_ball.position.x == 400
    assert moved_ball.position.y == 70
  end

  test "bounce/1 returns struct with updated velocity" do
    position = %Vector{x: 420, y: 69}
    velocity = %Vector{x: -20, y: 1}
    radius = 12

    bounced_ball =
      %Ball{position: position, velocity: velocity, radius: radius}
      |> Ball.bounce(1, 10, :top)

    refute bounced_ball.velocity.x == velocity.x
    refute bounced_ball.velocity.y == velocity.y
  end

end

defmodule DongEngine.Ball do
  @moduledoc """
  Representation of the ball used in play
  """

  alias __MODULE__
  alias DongEngine.Physics.Vector

  @enforce_keys [:position, :velocity, :radius]
  defstruct [:position, :velocity, :radius]

  def new(%Vector{} = position, %Vector{} = velocity, radius) do
    {
      :ok,
      %Ball{
        position: position,
        velocity: velocity,
        radius: radius
      }
    }
  end

  def check_collision(%Ball{} = ball, %Vector{x: board_width, y: board_height}) do
    cond do
      calculate_edge(ball, :top) <= 0 -> :top
      calculate_edge(ball, :bottom) >= board_height -> :bottom
      calculate_edge(ball, :left) <= 0 -> :left
      calculate_edge(ball, :right) >= board_width -> :right
      true -> :none
    end
  end

  def move(%Ball{} = ball) do
    new_x = ball.position.x + ball.velocity.x
    new_y = ball.position.y + ball.velocity.y
    Map.put(ball, :position, %Vector{x: new_x, y: new_y})
  end

  def bounce(%Ball{} = ball, min_velocity, max_velocity, collision) do
    new_velocity = random_float(min_velocity, max_velocity)
    new_direction = random_float(0, 2*:math.pi)
    x_component = calculate_x_component(new_direction, new_velocity)
    y_component = calculate_y_component(new_direction, new_velocity)
    Map.put(ball, :velocity, %Vector{x: x_component, y: y_component})
  end

  def calculate_edge(%Ball{} = ball, :top), do: ball.position.y - ball.radius
  def calculate_edge(%Ball{} = ball, :bottom), do: ball.position.y + ball.radius
  def calculate_edge(%Ball{} = ball, :left), do: ball.position.x - ball.radius
  def calculate_edge(%Ball{} = ball, :right), do: ball.position.x + ball.radius
  def calculate_edge(_ball, edge), do: {:error, "Invalid Edge"}

  defp random_float(min, max) do
    min + :rand.uniform() * (max-min)
  end

  defp calculate_x_component(direction, velocity) do
    {sign, theta} = cond do
      direction <= :math.pi/2 -> {1, direction}
      direction <= :math.pi -> {-1, :math.pi - direction}
      direction <= :math.pi*1.5 -> {-1, direction - :math.pi}
      true -> {1, 2*:math.pi - direction}
    end
    sign*velocity*:math.cos(theta)
  end

  defp calculate_y_component(direction, velocity) do
    {sign, theta} = cond do
      direction <= :math.pi/2 -> {1, direction}
      direction <= :math.pi -> {1, :math.pi - direction}
      direction <= :math.pi*1.5 -> {-1, direction - :math.pi}
      true -> {-1, 2*:math.pi - direction}
    end
    sign*velocity*:math.sin(theta)
  end
end

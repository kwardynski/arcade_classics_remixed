defmodule DongEngineTest do
  use ExUnit.Case
  doctest DongEngine

  test "greets the world" do
    assert DongEngine.hello() == :world
  end
end

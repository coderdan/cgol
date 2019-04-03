defmodule CgolTest do
  use ExUnit.Case
  doctest Cgol

  test "greets the world" do
    assert Cgol.hello() == :world
  end
end

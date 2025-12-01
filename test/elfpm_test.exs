defmodule ElfpmTest do
  use ExUnit.Case
  doctest Elfpm

  test "greets the world" do
    assert Elfpm.hello() == :world
  end
end

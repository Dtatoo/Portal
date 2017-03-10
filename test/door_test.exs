defmodule DoorTest do
  use ExUnit.Case, async: true

  alias Portal.Door

  @color :pink

  setup do
    Door.start_link(@color)
    :ok
  end

  test "make sure agent doesn't contain any data" do
    assert Door.get(@color) == []
  end

  test "start agent link with name blue" do
    {:ok, agent} = Door.start_link(:blue)
    assert Process.alive?(agent)
  end

  test "update the list with a value" do
    Door.push(@color, 2)
    list = Door.get(@color)
    assert list == [2], "make sure number is inserted"
  end

  test "cannot pop from the list when the list is empty" do
    assert Door.pop(@color) == :error
  end

  test "pop a value from a list" do
    Door.push(@color, 1)
    Door.push(@color, 2)
    Door.push(@color, 3)

    {:ok, _number} = Door.pop @color
    list_length =
      Door.get(@color)
      |> length

    assert list_length == 2
  end

  test "state can be cleaned up" do
    {:ok, process_id} = Door.start_link :green
    assert Process.alive? process_id

    Door.clean :green
    refute Process.alive? process_id
  end
end

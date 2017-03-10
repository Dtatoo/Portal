defmodule PortalTest do
  use ExUnit.Case

  alias Portal.Door

  setup do
    Door.start_link :orange
    Door.start_link :blue

    portal = Portal.transfer :orange, :blue, [1,2,3,4,5]
    {:ok, [portal: portal]}
  end

  test "data will be set on the left side" do
    assert :orange |> Door.get |> length == 5
    assert :orange |> Door.get == [5,4,3,2,1]
  end

  test "data is transfered to blue left door", %{portal: portal} do
    Portal.push_right portal
    Portal.push_right portal
    Portal.push_right portal

    assert :blue |> Door.get |> length == 3
    assert :orange |> Door.get |> length == 2

    assert :blue |> Door.get == [3,4,5]
    assert :orange |> Door.get == [2,1]
  end

end

defmodule AdventOfCode2018.Day2Test do
  use ExUnit.Case

  import TestHelper

  alias AdventOfCode2018.Day2

  describe "Day 2 Part 1" do
    test "" do
      :day2
      |> load_input_from_file()
      |> Day2.checksum()
      |> IO.inspect(label: "Day 2 Part 1")
    end
  end

  describe "Day 2 Part 2" do
    test "" do
      :day2
      |> load_input_from_file()
      |> Day2.find_similar_box_id()
      |> IO.inspect(label: "Day 2 Part 2")
    end
  end
end

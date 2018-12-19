defmodule AdventOfCode2018.Day3Test do
  use ExUnit.Case

  import TestHelper

  alias AdventOfCode2018.Day3

  describe "Day 3 Part 1" do
    test "" do
      :day3
      |> load_input_from_file()
      |> Day3.overlap_inches()
      |> IO.inspect(label: "Day 3 part 1")
      |> Enum.count()
      |> IO.inspect(label: "Day 3 part 1")
    end
  end

  describe "Day 3 Part 2" do
    test "" do
      # TODO
    end
  end
end

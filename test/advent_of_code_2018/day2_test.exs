defmodule AdventOfCode2018.Day2Test do
  use ExUnit.Case
  import TestHelper
  alias AdventOfCode2018.Day2

  describe "Day 2 Part 1" do
    test "return the expected answer from the challenge input" do
      result =
        :day2
        |> load_input_from_file()
        |> Day2.checksum()

      assert result == 7_221
    end
  end

  describe "Day 2 Part 2" do
    test "return the expected answer from the challenge input" do
      result =
        :day2
        |> load_input_from_file()
        |> Day2.find_similar_box_id()

      assert result == "mkcdflathzwsvjxrevymbdpoq"
    end
  end
end

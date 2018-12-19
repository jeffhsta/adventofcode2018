defmodule AdventOfCode2018.Day1Test do
  use ExUnit.Case
  import TestHelper
  alias AdventOfCode2018.Day1

  describe "Day 1 Part 1" do
    test "return the expected answer from the challenge input" do
      expected = 525

      result =
        :day1
        |> load_input_from_file()
        |> Day1.calc_frequency_pt1()

      assert expected == result
    end
  end

  describe "Day 1 Part 2" do
    test "return the expected answer from the challenge input" do
      expected = 75749

      result =
        :day1
        |> load_input_from_file()
        |> Day1.calc_frequency_pt2()

      assert expected == result
    end
  end
end

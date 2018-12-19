defmodule AdventOfCode2018.Day1 do
  def calc_frequency_pt1(raw_values) do
    raw_values
    |> parse_to_integer()
    |> Enum.reduce(0, &(&1 + &2))
  end

  def calc_frequency_pt2(raw_values) do
    values = parse_to_integer(raw_values)
    next_frequency(values, values, 0, [])
  end

  defp parse_to_integer(raw_values) do
    Enum.map(raw_values, fn raw_value ->
      {num, ""} = Integer.parse(raw_value)
      num
    end)
  end

  defp next_frequency(original_values, [], current, old_results) do
    next_frequency(original_values, original_values, current, old_results)
  end

  defp next_frequency(original_values, [next | rest], current, old_results) do
    if current in old_results do
      current
    else
      next_frequency(original_values, rest, current + next, [current | old_results])
    end
  end

  defp parse_str_to_int(str) do
    with clean_str <- String.trim(str),
         {number, ""} <- Integer.parse(clean_str) do
      number
    end
  end
end

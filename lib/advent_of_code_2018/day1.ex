defmodule AdventOfCode2018.Day1 do
  def calc_frequency_pt1(command) do
    command
    |> parse_command()
    |> Enum.reduce(0, &(&1 + &2))
  end

  def calc_frequency_pt2(command) do
    values = parse_command(command)
    next_frequency(values, values, 0, [])
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

  defp parse_command(command) do
    command
    |> String.split(",")
    |> Enum.map(&parse_str_to_int/1)
  end

  defp parse_str_to_int(str) do
    with clean_str <- String.trim(str),
         {number, ""} <- Integer.parse(clean_str) do
      number
    end
  end
end

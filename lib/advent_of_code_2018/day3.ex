defmodule AdventOfCode2018.Day3 do
  def overlap_inches(input) do
    input
    |> parse_input()
    |> Enum.map(&render/1)
    |> find_colisions()
    |> MapSet.new()
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_input_data/1)
  end

  defp parse_input_data(str_data) do
    pattern = ~r/^\#(\d)+ \@ (\d)+,(\d)+: (\d)+x(\d)+$/
    [_, id, left_m, top_m, width, height] = Regex.run(pattern, str_data)

    %{
      id: id |> Integer.parse() |> elem(0),
      left_margin: left_m |> Integer.parse() |> elem(0),
      top_margin: top_m |> Integer.parse() |> elem(0),
      width: width |> Integer.parse() |> elem(0),
      height: height |> Integer.parse() |> elem(0)
    }
  end

  defp render(rectangle) do
    top_start_point = rectangle.top_margin + 1
    left_start_point = rectangle.left_margin + 1

    rendered =
      Enum.map(top_start_point..(rectangle.top_margin + rectangle.height), fn pos_y ->
        Enum.map(left_start_point..(rectangle.left_margin + rectangle.width), &({&1, pos_y}))
      end)

    Map.put(rectangle, :rendered, rendered)
  end

  defp find_colisions(rectangle_list) do
    [first_matrix | rest] = Enum.map(rectangle_list, &(&1.rendered))
    find_colisions(first_matrix, rest, [])
  end

  defp find_colisions(_first_matrix, [], colisions), do: colisions
  defp find_colisions(first_matrix, matrix_list, colisions) do
    colisions =
      colisions ++
        Enum.map(matrix_list, fn compare_matrix ->
          Enum.map(first_matrix, fn line ->
            Enum.filter(line, fn position -> is_there_a_coligion?(position, compare_matrix) end)
          end)
          |> List.flatten()
        end)
        |> List.flatten()

    [next_matrix | rest] = matrix_list
    find_colisions(next_matrix, rest, colisions)
  end

  defp is_there_a_coligion?(position, compare_matrix) do
    Enum.any?(compare_matrix, fn line ->
      Enum.any?(line, fn compare_pos -> compare_pos == position end)
    end)
  end
end

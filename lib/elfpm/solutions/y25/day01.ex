defmodule Elfpm.Solutions.Y25.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    # This function will receive the input path or an %AoC.Input.TestInput{}
    # struct. To support the test you may read both types of input with either:
    #
    # * Input.stream!(input), equivalent to File.stream!/1
    # * Input.stream!(input, trim: true), equivalent to File.stream!/2
    # * Input.read!(input), equivalent to File.read!/1
    #
    # The role of your parse/2 function is to return a "problem" for the solve/2
    # function.
    #
    # For instance:
    #
    # input
    # |> Input.stream!()
    # |> Enum.map!(&my_parse_line_function/1)

    # Input.read!(input)

    input
    |> Input.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&line_parser/1)
  end

  def part_one(problem) do
    # This function receives the problem returned by parse/2 and must return
    # today's problem solution for part one.

    {final_count, _final_position} =
      problem
      |> Enum.map(&movement_parser/1)
      |> Enum.reduce({0, 50}, fn element, {count, position} ->
        case value_cycler(position + element) do
          0 -> {count + 1, 0}
          new_position -> {count, new_position}
        end
      end)

    final_count
  end

  # def part_two(problem) do
  #   problem
  # end
  #

  defp line_parser(<<direction::binary-size(1), distance::binary>>) do
    %{direction: direction, distance: String.to_integer(distance)}
  end

  defp movement_parser(%{direction: "L", distance: distance}), do: -1 * distance
  defp movement_parser(%{direction: "R", distance: distance}), do: distance

  defp value_cycler(number), do: (rem(number, 100) + 100) |> rem(100)
end

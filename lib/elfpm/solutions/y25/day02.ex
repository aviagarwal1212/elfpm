defmodule Elfpm.Solutions.Y25.Day02 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn range ->
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def part_one(problem) do
    problem
    |> Enum.flat_map(&process_range/1)
    |> Enum.sum()
  end

  defp process_range([head, tail]) do
    head..tail
    |> Enum.filter(&check_numbers_one/1)
  end

  defp check_numbers_one(input) do
    string = Integer.to_string(input)
    len = String.length(string)

    cond do
      rem(len, 2) == 0 ->
        size = div(len, 2)
        string |> chunk_string(size) |> check_repeating_string()

      true ->
        false
    end
  end

  def part_two(problem) do
    problem
    |> Enum.flat_map(&process_range_two/1)
  end

  def check_number(input, 0, state) do
    state
    |> Enum.any?()
  end

  defp check_number(input, size, state) do
    state =
      cond do
        rem(String.length(input), size) == 0 ->
          [input |> chunk_string(size) |> check_repeating_string() | state]

        true ->
          [false | state]
      end

    check_number(input, size - 1, state)
  end

  defp chunk_string(input, size) do
    for <<chunk::size(size)-binary <- input>>, do: chunk
  end

  defp check_repeating_string([head | rest]), do: Enum.all?(rest, fn chunk -> chunk == head end)
  defp check_repeating_string(_input), do: false
end

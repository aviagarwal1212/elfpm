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
    |> Enum.flat_map(fn [head, tail] -> head..tail end)
    |> Enum.filter(&check_repeating_chunks(&1, 2))
    |> Enum.sum()
  end

  def check_repeating_chunks(number, chunk_count) do
    digits = Integer.digits(number)

    cond do
      rem(length(digits), chunk_count) == 0 ->
        size = div(length(digits), chunk_count)
        digits |> Enum.chunk_every(size) |> check_repeating_items()

      true ->
        false
    end
  end

  def check_repeating_items([head | rest]), do: Enum.all?(rest, fn item -> item == head end)
  def check_repeating_items(_list), do: false

  # def part_two(problem) do
  #   problem
  #   |> Enum.flat_map(&process_range_two/1)
  # end
end

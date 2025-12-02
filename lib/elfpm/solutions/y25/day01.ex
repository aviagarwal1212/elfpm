defmodule Elfpm.Solutions.Y25.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&line_parser/1)
  end

  def part_one(problem) do
    problem
    |> Enum.map(&simple_movement_parser/1)
    |> Enum.reduce({0, 50}, fn rotation, {count, position} ->
      case Integer.mod(position + rotation, 100) do
        0 -> {count + 1, 0}
        position -> {count, position}
      end
    end)
    |> elem(0)
  end

  def part_two(problem) do
    problem
    |> Enum.flat_map(&movement_splitter/1)
    |> Enum.reduce({0, "R", 50}, &movement_processor/2)
    |> elem(0)
  end

  defp line_parser(<<direction::binary-size(1), distance::binary>>) do
    %{direction: direction, distance: String.to_integer(distance)}
  end

  defp simple_movement_parser(%{direction: "L", distance: distance}), do: -1 * distance
  defp simple_movement_parser(%{direction: "R", distance: distance}), do: distance

  def movement_splitter(rotation), do: movement_splitter(rotation, [])

  defp movement_splitter(%{distance: distance} = rotation, movements) when distance > 100 do
    %{rotation | distance: distance - 100}
    |> movement_splitter([%{rotation | distance: 100} | movements])
  end

  defp movement_splitter(rotation, movements) do
    [rotation | movements]
  end

  defp movement_processor(%{direction: direction, distance: 100}, {count, _direction, position}) do
    {count + 1, direction, position}
  end

  defp movement_processor(%{direction: "R", distance: distance}, {count, "L", 0}) do
    {count + 1, "R", distance}
  end

  defp movement_processor(%{direction: "R", distance: distance}, {count, _direction, position}) do
    new_position = Integer.mod(position + distance, 100)

    cond do
      new_position < position -> {count + 1, "R", new_position}
      true -> {count, "R", new_position}
    end
  end

  defp movement_processor(%{direction: "L", distance: distance}, {count, "R", 0}) do
    {count, "L", Integer.mod(-distance, 100)}
  end

  defp movement_processor(%{direction: "L", distance: distance}, {count, _direction, position}) do
    new_position = Integer.mod(position - distance, 100)

    cond do
      new_position > position -> {count + 1, "L", new_position}
      true -> {count, "L", new_position}
    end
  end
end

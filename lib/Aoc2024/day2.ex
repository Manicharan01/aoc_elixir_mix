defmodule Aoc2024.Day2 do
  def is_ordered?(list) when length(list) < 2 do
    false
  end

  def is_ordered?(list) do
    cond do
      ascending?(list) ->
        true

      descending?(list) ->
        true

      true ->
        false
    end
  end

  defp ascending?([a, b | rest]) when a <= b do
    ascending?([b | rest])
  end

  defp ascending?([_a, _b | _rest]), do: false
  defp ascending?([_a]), do: true

  defp descending?([a, b | rest]) when a >= b do
    descending?([b | rest])
  end

  defp descending?([_a, _b | _rest]), do: false
  defp descending?([_a]), do: true

  def is_valid?(list) when length(list) < 2 do
    false
  end

  def is_valid?(list) when is_list(list) do
    cond do
      is_ordered?(list) ->
        Enum.chunk_every(list, 2, 1, :discard)
        |> Enum.all?(fn [a, b] -> abs(b - a) in 1..3 end)

      true ->
        false
    end
  end
end

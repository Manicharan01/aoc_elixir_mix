defmodule Aoc2019.Day2 do
  def traverse(list) do
    traverse(list, 0)
  end

  defp traverse(list, position) do
    case Enum.at(list, position) do
      # Addition
      1 ->
        list
        |> apply_operation(position, &+/2)
        |> traverse(position + 4)

      # Multiplication
      2 ->
        list
        |> apply_operation(position, &*/2)
        |> traverse(position + 4)

      # halt
      99 ->
        list

      _ ->
        IO.puts("Invalid operation")
        list
    end
  end

  defp apply_operation(list, position, operation) do
    {index1, index2, index3} =
      {Enum.at(list, position + 1), Enum.at(list, position + 2), Enum.at(list, position + 3)}

    {value1, value2} = {Enum.at(list, index1), Enum.at(list, index2)}

    List.replace_at(list, index3, operation.(value1, value2))
  end

  def find_noun_and_verb(list, target_output) do
    for noun <- 0..99, verb <- 0..99 do
      modified_list = List.replace_at(list, 1, noun) |> List.replace_at(2, verb)

      result = traverse(modified_list) |> Enum.at(0)

      if result == target_output do
        IO.puts("Found noun: #{noun} and verb: #{verb}")
        IO.puts("Answer: #{100 * noun + verb}")
      end
    end
  end
end

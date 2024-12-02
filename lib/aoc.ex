defmodule Day1 do
  def calculate_fuel_for_fuel(x) when x > 0 do
    x + calculate_fuel_for_fuel(div(x, 3) - 2)
  end

  def calculate_fuel_for_fuel(x) when x <= 0 do
    0
  end
end

defmodule Day2 do
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

defmodule Day2_2024 do
  def is_sorted(list) when is_list(list) do
    Enum.reduce_while(list, true, fn
      a, true -> {:cont, a}
      a, b when a >= b -> {:cont, true}
      _a, _b -> {:halt, false}
    end) != false
  end
end

defmodule Aoc do
  def day1() do
    File.stream!("/home/charan/Downloads/aoc/day1.txt", :line)
    |> Enum.to_list()
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.filter(fn x -> String.trim(x) != "" end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.map(fn x -> div(x, 3) - 2 end)
    |> Enum.map(fn x -> Day1.calculate_fuel_for_fuel(x) end)
    |> Enum.sum()
  end

  def day2() do
    [file_content] =
      File.stream!("/home/charan/Downloads/aoc/day2.txt", :line)
      |> Enum.to_list()
      |> Enum.map(fn x -> String.trim(x) end)

    Day2.traverse(
      String.split(file_content, ",")
      |> Enum.filter(fn x -> String.trim(x) != "" end)
      |> Enum.map(fn x -> String.to_integer(x) end)
    )

    target_output = 19_690_720

    Day2.find_noun_and_verb(
      String.split(file_content, ",")
      |> Enum.filter(fn x -> String.trim(x) != "" end)
      |> Enum.map(fn x -> String.to_integer(x) end),
      target_output
    )
  end

  def day1_2024() do
    list =
      File.stream!("/home/charan/Downloads/aoc/2024_day1.input", :line)
      |> Stream.map(&String.trim/1)
      |> Stream.filter(&(byte_size(&1) > 0))
      |> Stream.map(&String.split(&1, " "))
      |> Enum.to_list()

    {left, right} =
      list
      |> Enum.reduce({[], []}, fn value, {list1, list2} ->
        a = String.to_integer(Enum.at(value, 0))
        b = String.to_integer(Enum.at(value, 3))
        {[a | list1], [b | list2]}
      end)

    left_sorted = Enum.sort(left)
    right_sorted = Enum.sort(right)

    frequency = Enum.frequencies(right_sorted)

    left_sorted
    |> Enum.map(fn x -> x * Map.get(frequency, x, 0) end)
    |> Enum.sum()

    # Enum.zip([left_sorted, right_sorted])
    # |> Enum.map(fn {x, y} -> abs(y - x) end)
    # |> Enum.sum()
  end

  def day2_2024() do
    File.stream!("/home/charan/Downloads/aoc/2024_day2.test", :line)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(byte_size(&1) > 0))
    |> Stream.map(&String.split(&1, " "))
    |> Enum.to_list()
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> Day2_2024.is_sorted(x) end)
  end
end

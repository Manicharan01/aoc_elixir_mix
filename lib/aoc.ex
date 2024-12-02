defmodule Aoc do
  import Aoc2019.Day1
  import Aoc2019.Day2
  import Aoc2024.Day2

  def day1() do
    File.stream!("/home/charan/Downloads/aoc/day1.txt", :line)
    |> Enum.to_list()
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.filter(fn x -> String.trim(x) != "" end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.map(fn x -> div(x, 3) - 2 end)
    |> Enum.map(fn x -> calculate_fuel_for_fuel(x) end)
    |> Enum.sum()
  end

  def day2() do
    [file_content] =
      File.stream!("/home/charan/Downloads/aoc/day2.txt", :line)
      |> Enum.to_list()
      |> Enum.map(fn x -> String.trim(x) end)

    traverse(
      String.split(file_content, ",")
      |> Enum.filter(fn x -> String.trim(x) != "" end)
      |> Enum.map(fn x -> String.to_integer(x) end)
    )

    target_output = 19_690_720

    find_noun_and_verb(
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
    File.stream!("/home/charan/Downloads/aoc/2024_day2.input", :line)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(byte_size(&1) > 0))
    |> Stream.map(&String.split(&1, " "))
    |> Enum.to_list()
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> is_valid?(x) end)
    |> Enum.map(fn x -> if x, do: 1, else: 0 end)
    |> Enum.sum()
  end
end

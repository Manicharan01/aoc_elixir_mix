defmodule AdventofCode.Main do
  alias AdventofCode.Day2_2024

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

defmodule Aoc2019.Day1 do
  def calculate_fuel_for_fuel(x) when x > 0 do
    x + calculate_fuel_for_fuel(div(x, 3) - 2)
  end

  def calculate_fuel_for_fuel(x) when x <= 0 do
    0
  end
end

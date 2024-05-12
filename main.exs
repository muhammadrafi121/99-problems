defmodule Main do

  @doc """
    solution for Problem 1.01
  """
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | rest]), do: last(rest)
end

ExUnit.start()

defmodule MainTest do
  use ExUnit.Case

  import Main

  @doc """
    Test for Problem 1.01
  """
  test "last for []" do
    assert last([]) == nil
  end

  test "last for list with 1 element" do
    assert last(["a"]) == "a"
  end

  test "last for list with more than 1 element" do
    assert last(["a", 1, 2, 0.5]) == 0.5
  end
end

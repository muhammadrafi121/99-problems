defmodule Main do

  @doc """
    solution for Problem 1.01
  """
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | rest]), do: last(rest)

  @doc """
    solution for Problem 1.02
  """
  def last_but_one([]), do: nil
  def last_but_one([_]), do: nil
  def last_but_one([x, _]), do: x
  def last_but_one([_ | xs]), do: last_but_one(xs)
end

ExUnit.start()

defmodule MainTest do
  use ExUnit.Case

  import Main

  @doc """
    Test for Problem 1.01
  """
  test "last" do
    assert last([]) == nil
    assert last(["a"]) == "a"
    assert last(["a", 1, 2, 0.5]) == 0.5
  end

  @doc """
    Test for Problem 1.02
  """
  test "last but one" do
    assert last_but_one([]) == nil
    assert last_but_one([2]) == nil
    assert last_but_one([1, 2]) == 1
    assert last_but_one(Enum.to_list(1..100)) == 99
  end
end

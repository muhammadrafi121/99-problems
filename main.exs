defmodule Main do

  @doc """
    solution for problem 1.01
  """
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | rest]), do: last(rest)

  @doc """
    solution for problem 1.02
  """
  def last_but_one([]), do: nil
  def last_but_one([_]), do: nil
  def last_but_one([x, _]), do: x
  def last_but_one([_ | xs]), do: last_but_one(xs)

  @doc """
    solution for problem 1.03
  """
  def at(_, []), do: nil
  def at(0, _), do: nil
  def at(k, [x | rest]) do
    case k do
      1 -> x
      _ -> at(k-1, rest)
    end
  end

  @doc """
    solution for problem 1.04
  """
  def list_length([]), do: 0
  def list_length([_ | xs]), do: 1 + list_length(xs)

  @doc """
    solution for problem 1.05
  """
  def list_reverse([]), do: []
  def list_reverse([x | xs]), do: list_reverse(xs) ++ [x]

  @doc """
    solution for problem 1.06
  """
  def is_palindrome(xs), do: xs == list_reverse(xs)
end

ExUnit.start()

defmodule MainTest do
  use ExUnit.Case

  import Main

  @doc """
    test for problem 1.01
  """
  test "last" do
    assert last([]) == nil
    assert last(["a"]) == "a"
    assert last(["a", 1, 2, 0.5]) == 0.5
  end

  @doc """
    test for problem 1.02
  """
  test "last but one" do
    assert last_but_one([]) == nil
    assert last_but_one([2]) == nil
    assert last_but_one([1, 2]) == 1
    assert last_but_one(Enum.to_list(1..100)) == 99
  end

  @doc """
    test for problem 1.03
  """
  test "element at" do
    assert at(0, Enum.to_list(1..100)) == nil
    assert at(1, []) == nil
    assert at(2, [1]) == nil
    assert at(20, Enum.to_list(1..100)) == 20
  end

  @doc """
    test for problem 1.04
  """
  test "number of elements of a list" do
    assert list_length([]) == 0
    assert list_length([1]) == 1
    assert list_length([1, 2, 3]) == 3
    assert list_length(Enum.to_list(1..1000)) == 1000
  end

  @doc """
    test for problem 1.05
  """
  test "reverse a list" do
    assert list_reverse([]) == []
    assert list_reverse([1, 2, 3, 4]) == [4, 3, 2, 1]
  end

  @doc """
    test for problem 1.06
  """
  test "is palindrome" do
    assert is_palindrome([]) == true
    assert is_palindrome([1, 2, 3, 4]) == false
    assert is_palindrome([1, 2, 3, 2, 1]) == true
    assert is_palindrome('madam') == true
  end
end

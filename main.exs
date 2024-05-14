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
  def list_length(xs), do: length_tail(0, xs)

  def length_tail(acc, []), do: acc
  def length_tail(acc, [_ | xs]), do: length_tail(acc+1, xs)

  @doc """
    solution for problem 1.05
  """
  def list_reverse([]), do: []
  def list_reverse([x | xs]), do: list_reverse(xs) ++ [x]

  @doc """
    solution for problem 1.06
  """
  def is_palindrome(xs), do: xs == list_reverse(xs)

  @doc """
    solution for problem 1.07
  """
  def flatten(x) when not is_list(x), do: [x]
  def flatten([]), do: []
  def flatten([x | xs]), do: flatten(x) ++ flatten(xs)

  @doc """
    solution for problem 1.08
  """
  def compress([]), do: []
  def compress([x, y | rest]) when x == y, do: [x] ++ compress(rest)
  def compress([x | rest]), do: [x] ++ compress(rest)

  @doc """
    solution for problem 1.09
  """
  def pack([]), do: []
  def pack([x]), do: [[x]]
  def pack([x | rest]) do
    cond do
      x == hd(rest) ->
        [[x] ++ hd(pack(rest)) | tl(pack(rest))]
      true ->
        [[x] | pack(rest)]
    end
  end

  @doc """
    solution for problem 1.10
  """
  def encode(xs) do
    for x <- pack(xs), do: [list_length(x), hd(x)]
  end

  @doc """
    solution for problem 1.11
  """
  def encode_modified(xs) do
    for x <- pack(xs) do
      if list_length(x) == 1 do
        hd(x)
      else
        [list_length(x), hd(x)]
      end
    end
  end

  @doc """
    solution for problem 1.12
  """
  def decode_modified([]), do: []
  def decode_modified([[2, x] | rest]), do: [x, x] ++ decode_modified(rest)
  def decode_modified([[n, x] | rest]), do: [x] ++ decode_modified([[n-1, x] | rest])
  def decode_modified([x | rest]), do: [x] ++ decode_modified(rest)

  @doc """
    solution for problem 1.13
  """
  def encode_direct([]), do: []
  def encode_direct([x | rest]), do: encode_direct(1, x, rest)
  def encode_direct(n, x, []), do: [encode_element(n, x)]
  def encode_direct(n, x, [y | rest]) do
    cond do
      x == y ->
        encode_direct(n+1, x, rest)
      true ->
        [encode_element(n, x) | encode_direct(1, y, rest)]
    end
  end

  def encode_element(1, x), do: x
  def encode_element(n, x), do: [n, x]

  @doc """
    solution for problem 1.14
  """
  def dupli([]), do: []
  def dupli([x | rest]), do: [x, x] ++ dupli(rest)

  @doc """
    solution for problem 1.15
  """
  def repli([], _), do: []
  def repli([x], 1), do: [x]
  def repli([x], n), do: [x] ++ repli([x], n-1)
  def repli([x | rest], n), do: repli([x], n) ++ repli(rest, n)

  @doc """
    solution for problem 1.16
  """
  def drop_every(xs, n), do: drop_element(xs, n, n)
  def drop_element([], _, _), do: []
  def drop_element([_ | rest], count, 1), do: drop_element(rest, count, count)
  def drop_element([x | rest], count, n), do: [x] ++ drop_element(rest, count, n-1)

  @doc """
    solution for problem 1.17
  """
  def split([x | rest], n) when n > 0 do
    {first, last} = split(rest, n - 1)
    {[x | first], last}
  end
  def split(xs, _), do: {[], xs}

  @doc """
    solution for problem 1.18
  """
  def slice(xs, i, j), do: Enum.drop(Enum.take(xs, j), i-1)

  @doc """
    solution for problem 1.19
  """
  def rotate([], _), do: []
  def rotate(xs, 0), do: xs
  def rotate([x | xs], n) when n > 0, do: rotate(xs ++ [x], n-1)
  def rotate(xs, n), do: rotate(xs, list_length(xs) + n)

  @doc """
    solution for problem 1.20
  """
  def remove_at([], _), do: {nil, []}
  def remove_at([x | rest], 1), do: {x, rest}
  def remove_at([x | rest], n) do
    {a, b} = remove_at(rest, n-1)
    {a, [x | b]}
  end
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

  @doc """
    test for problem 1.07
  """
  test "flatten list" do
    assert flatten([1, 2, [3, 4, 5], 6]) == [1, 2, 3, 4, 5, 6]
    assert flatten([1, 2, [[3, 4], 5], 6]) == [1, 2, 3, 4, 5, 6]
  end

  @doc """
    test for problem 1.08
  """
  test "eliminate consecutive duplicates of list elements." do
    assert compress([1, 2, 2, 3, 4, 5, 5, 2, 2, 6, 7]) == [1, 2, 3, 4, 5, 2, 6, 7]
  end

  @doc """
    test for problem 1.09
  """
  test "Pack consecutive duplicates of list elements into sublists." do
    assert pack([]) == []
    assert pack([1]) == [[1]]
    assert pack([1, 2, 3, 4, 5]) == [[1], [2], [3], [4], [5]]
    assert pack([1, 1, 1, 1, 2, 3, 4, 4, 4, 2, 2, 5]) == [[1, 1, 1, 1], [2], [3], [4, 4, 4], [2, 2], [5]]
  end

  @doc """
    test for problem 1.10
  """
  test "Run-length encoding of a list." do
    assert encode([]) == []
    assert encode([1]) == [[1, 1]]
    assert encode([1, 2, 3, 4, 5]) == [[1, 1], [1, 2], [1, 3], [1, 4], [1, 5]]
    assert encode([1, 1, 1, 1, 2, 3, 4, 4, 4, 2, 2, 5]) == [[4, 1], [1, 2], [1, 3], [3, 4], [2, 2], [1, 5]]
  end

  @doc """
    test for problem 1.11
  """
  test "Modified run-length encoding." do
    assert encode_modified([]) == []
    assert encode_modified([1]) == [1]
    assert encode_modified([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
    assert encode_modified([1, 1, 1, 1, 2, 3, 4, 4, 4, 2, 2, 5]) == [[4, 1], 2, 3, [3, 4], [2, 2], 5]
  end

  @doc """
    test for problem 1.12
  """
  test "Decode a run-length encoded list." do
    assert decode_modified([]) == []
    assert decode_modified([1]) == [1]
    assert decode_modified([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
    assert decode_modified([[4, 1], 2, 3, [3, 4], [2, 2], 5]) == [1, 1, 1, 1, 2, 3, 4, 4, 4, 2, 2, 5]
  end

  @doc """
    test for problem 1.13
  """
  test "Run-length encoding of a list (direct solution)." do
    assert encode_direct([]) == []
    assert encode_direct([1]) == [1]
    assert encode_direct([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
    assert encode_direct([1, 1, 1, 1, 2, 3, 4, 4, 4, 2, 2, 5]) == [[4, 1], 2, 3, [3, 4], [2, 2], 5]
  end

  @doc """
    test for problem 1.14
  """
  test "Duplicate the elements of a list." do
    assert dupli([]) == []
    assert dupli([1]) == [1, 1]
    assert dupli([1, 2, 3, 3, 4, 5, 6]) == [1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 5, 5, 6, 6]
  end

  @doc """
    test for problem 1.15
  """
  test "Duplicate the elements of a list a given number of times." do
    assert repli([], 2) == []
    assert repli([1], 1) == [1]
    assert repli([1], 4) == [1, 1, 1, 1]
    assert repli([1, 2, 3, 3, 4, 5, 6], 3) == [1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6]
  end

  @doc """
    test for problem 1.16
  """
  test "Drop every N'th element from a list." do
    assert drop_every([], 2) == []
    assert drop_every([1, 2, 3, 4, 5], 2) == [1, 3, 5]
    assert drop_every([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3) == [1, 2, 4, 5, 7, 8, 10]
  end

  @doc """
    test for problem 1.17
  """
  test "Split a list into two parts; the length of the first part is given." do
    assert split([], 2) == {[], []}
    assert split([1, 2, 3, 4, 5], 2) == {[1, 2], [3, 4, 5]}
  end

  @doc """
    test for problem 1.18
  """
  test "Extract a slice from a list." do
    assert slice([], 1, 2) == []
    assert slice([1, 2, 3, 4, 5], 2, 2) == [2]
    assert slice([1, 2, 3, 4, 5, 6, 7, 8, 9], 2, 7) == [2, 3, 4, 5, 6, 7]
  end

  @doc """
    test for problem 1.19
  """
  test "Rotate a list N places to the left." do
    assert rotate('abcdefgh', 3) == 'defghabc'
    assert rotate('abcdefgh', -2) == 'ghabcdef'
  end

  @doc """
    test for problem 1.20
  """
  test "Remove the K'th element from a list." do
    assert remove_at([1, 2, 3, 4], 2) == {2, [1, 3, 4]}
    assert remove_at([1, 2, 3, 4, 5], 3) == {3, [1, 2, 4, 5]}
  end
end

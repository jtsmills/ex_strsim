defmodule ExStrsimTest do
  use ExUnit.Case, async: true
  doctest ExStrsim

  describe "empty strings" do
    test "distance functions return string length" do
      assert ExStrsim.levenshtein("abc", "") == 3
      assert ExStrsim.levenshtein("", "abc") == 3
      assert ExStrsim.levenshtein("", "") == 0
    end

    test "similarity functions" do
      assert ExStrsim.jaro("", "") == 1.0
      assert ExStrsim.normalized_levenshtein("", "") == 1.0
    end
  end

  describe "utf8" do
    test "handles unicode strings" do
      assert ExStrsim.levenshtein("über", "uber") == 1
      assert ExStrsim.jaro("café", "cafe") > 0.0
      assert ExStrsim.hamming("日本語", "日本人") == 1
    end
  end

  describe "error wrapping" do
    test "hamming returns error tuple for different lengths" do
      assert {:error, :different_length_args} = ExStrsim.hamming("abc", "ab")
    end

    test "generic_hamming returns error tuple for different lengths" do
      assert {:error, :different_length_args} = ExStrsim.generic_hamming(["a"], ["a", "b"])
    end
  end
end

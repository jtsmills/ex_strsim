defmodule ExStrsim do
  @moduledoc """
  Fast string similarity metrics powered by the Rust
  [strsim](https://crates.io/crates/strsim) crate via NIF.

  Distance functions return non-negative integers, similarity
  functions return floats between `0.0` and `1.0`.
  """

  @doc """
  Levenshtein edit distance (insertions, deletions, substitutions).

      iex> ExStrsim.levenshtein("kitten", "sitting")
      3
  """
  @spec levenshtein(String.t(), String.t()) :: non_neg_integer()
  def levenshtein(a, b), do: ExStrsim.Native.levenshtein(a, b)

  @doc """
  Normalized Levenshtein similarity (`0.0` to `1.0`).

      iex> ExStrsim.normalized_levenshtein("kitten", "sitting")
      0.5714285714285714
  """
  @spec normalized_levenshtein(String.t(), String.t()) :: float()
  def normalized_levenshtein(a, b), do: ExStrsim.Native.normalized_levenshtein(a, b)

  @doc """
  Jaro similarity (`0.0` to `1.0`).

      iex> ExStrsim.jaro("martha", "marhta")
      0.9444444444444445
  """
  @spec jaro(String.t(), String.t()) :: float()
  def jaro(a, b), do: ExStrsim.Native.jaro(a, b)

  @doc """
  Jaro-Winkler similarity — like Jaro, but boosts strings sharing a common prefix.

      iex> ExStrsim.jaro_winkler("martha", "marhta")
      0.9611111111111111
  """
  @spec jaro_winkler(String.t(), String.t()) :: float()
  def jaro_winkler(a, b), do: ExStrsim.Native.jaro_winkler(a, b)

  @doc """
  Sorensen-Dice coefficient (`0.0` to `1.0`).

      iex> ExStrsim.sorensen_dice("night", "nacht")
      0.25
  """
  @spec sorensen_dice(String.t(), String.t()) :: float()
  def sorensen_dice(a, b), do: ExStrsim.Native.sorensen_dice(a, b)

  @doc """
  Hamming distance — strings must be equal length.

      iex> ExStrsim.hamming("karolin", "kathrin")
      3

      iex> ExStrsim.hamming("abc", "ab")
      {:error, :different_length_args}
  """
  @spec hamming(String.t(), String.t()) :: non_neg_integer() | {:error, :different_length_args}
  def hamming(a, b) do
    with {:error, _} <- ExStrsim.Native.hamming(a, b) do
      {:error, :different_length_args}
    end
  end

  @doc """
  Damerau-Levenshtein distance — like Levenshtein, but transpositions count as one edit.

      iex> ExStrsim.damerau_levenshtein("ab", "ba")
      1
  """
  @spec damerau_levenshtein(String.t(), String.t()) :: non_neg_integer()
  def damerau_levenshtein(a, b), do: ExStrsim.Native.damerau_levenshtein(a, b)

  @doc """
  Normalized Damerau-Levenshtein similarity (`0.0` to `1.0`).

      iex> ExStrsim.normalized_damerau_levenshtein("kitten", "sitting")
      0.5714285714285714
  """
  @spec normalized_damerau_levenshtein(String.t(), String.t()) :: float()
  def normalized_damerau_levenshtein(a, b),
    do: ExStrsim.Native.normalized_damerau_levenshtein(a, b)

  @doc """
  Optimal String Alignment distance — like Damerau-Levenshtein,
  but each substring may only be edited once.

      iex> ExStrsim.osa_distance("ca", "abc")
      3
  """
  @spec osa_distance(String.t(), String.t()) :: non_neg_integer()
  def osa_distance(a, b), do: ExStrsim.Native.osa_distance(a, b)

  @doc """
  Word-level Levenshtein distance.

      iex> ExStrsim.generic_levenshtein(["the", "quick", "fox"], ["the", "slow", "dog"])
      2
  """
  @spec generic_levenshtein([String.t()], [String.t()]) :: non_neg_integer()
  def generic_levenshtein(a, b), do: ExStrsim.Native.generic_levenshtein(a, b)

  @doc """
  Word-level Damerau-Levenshtein distance.

      iex> ExStrsim.generic_damerau_levenshtein(["a", "b"], ["b", "a"])
      1
  """
  @spec generic_damerau_levenshtein([String.t()], [String.t()]) :: non_neg_integer()
  def generic_damerau_levenshtein(a, b), do: ExStrsim.Native.generic_damerau_levenshtein(a, b)

  @doc """
  Word-level Hamming distance — lists must be equal length.

      iex> ExStrsim.generic_hamming(["a", "b", "c"], ["a", "x", "c"])
      1

      iex> ExStrsim.generic_hamming(["a"], ["a", "b"])
      {:error, :different_length_args}
  """
  @spec generic_hamming([String.t()], [String.t()]) ::
          non_neg_integer() | {:error, :different_length_args}
  def generic_hamming(a, b) do
    with {:error, _} <- ExStrsim.Native.generic_hamming(a, b) do
      {:error, :different_length_args}
    end
  end

  @doc """
  Word-level Jaro similarity (`0.0` to `1.0`).

      iex> ExStrsim.generic_jaro(["hello", "world"], ["hello", "world"])
      1.0
  """
  @spec generic_jaro([String.t()], [String.t()]) :: float()
  def generic_jaro(a, b), do: ExStrsim.Native.generic_jaro(a, b)

  @doc """
  Word-level Jaro-Winkler similarity (`0.0` to `1.0`).

      iex> ExStrsim.generic_jaro_winkler(["hello", "world"], ["hello", "world"])
      1.0
  """
  @spec generic_jaro_winkler([String.t()], [String.t()]) :: float()
  def generic_jaro_winkler(a, b), do: ExStrsim.Native.generic_jaro_winkler(a, b)
end

# ExStrsim

Fast string similarity metrics for Elixir via Rust NIF, wrapping the [strsim](https://crates.io/crates/strsim) crate.

Precompiled binaries are available — no Rust toolchain required.

## Installation

```elixir
def deps do
  [
    {:ex_strsim, "~> 0.1"}
  ]
end
```

## Usage

```elixir
ExStrsim.levenshtein("kitten", "sitting")
#=> 3

ExStrsim.normalized_levenshtein("kitten", "sitting")
#=> 0.5714285714285714

ExStrsim.jaro_winkler("cheeseburger", "cheese fries")
#=> 0.9

ExStrsim.damerau_levenshtein("ab", "ba")
#=> 1

# Word-level edit distance
ExStrsim.generic_levenshtein(["the", "quick", "fox"], ["the", "slow", "dog"])
#=> 2
```

## Available Functions

### String Distance

| Function | Returns | Description |
|---|---|---|
| `levenshtein/2` | integer | Edit distance (insertions, deletions, substitutions) |
| `damerau_levenshtein/2` | integer | Like Levenshtein, but transpositions count as one edit |
| `hamming/2` | integer / `{:error, reason}` | Hamming distance (equal-length strings only) |
| `osa_distance/2` | integer | Optimal String Alignment (restricted edit distance) |

### String Similarity

| Function | Returns | Description |
|---|---|---|
| `normalized_levenshtein/2` | float | Levenshtein normalized to 0.0–1.0 (1.0 = identical) |
| `normalized_damerau_levenshtein/2` | float | Damerau-Levenshtein normalized to 0.0–1.0 |
| `jaro/2` | float | Jaro similarity (0.0–1.0) |
| `jaro_winkler/2` | float | Jaro-Winkler similarity with common prefix boost |
| `sorensen_dice/2` | float | Sorensen-Dice coefficient (0.0–1.0) |

### Generic (Word-Level)

Operate on lists of strings instead of individual characters.

| Function | Returns | Description |
|---|---|---|
| `generic_levenshtein/2` | integer | Levenshtein on lists of strings |
| `generic_damerau_levenshtein/2` | integer | Damerau-Levenshtein on lists of strings |
| `generic_hamming/2` | integer / `{:error, reason}` | Hamming on lists of strings (equal length only) |
| `generic_jaro/2` | float | Jaro similarity on lists of strings |
| `generic_jaro_winkler/2` | float | Jaro-Winkler similarity on lists of strings |

## Building from Source

If you need to compile the NIF locally (requires Rust toolchain):

```bash
EX_STRSIM_BUILD=1 mix deps.compile ex_strsim
```

## License

MIT

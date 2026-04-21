defmodule ExStrsim.Native do
  @moduledoc false

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :ex_strsim,
    crate: "ex_strsim_nif",
    version: version,
    base_url: "#{github_url}/releases/download/v#{version}",
    targets: ~w(
      aarch64-apple-darwin
      aarch64-unknown-linux-gnu
      aarch64-unknown-linux-musl
      x86_64-apple-darwin
      x86_64-pc-windows-msvc
      x86_64-unknown-linux-gnu
      x86_64-unknown-linux-musl
    ),
    nif_versions: ["2.16", "2.17"],
    force_build:
      System.get_env("EX_STRSIM_BUILD") in ["1", "true"] or
        not File.exists?(Path.join(__DIR__, "../../checksum-Elixir.ExStrsim.Native.exs"))

  def levenshtein(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def normalized_levenshtein(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def jaro(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def jaro_winkler(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def sorensen_dice(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def hamming(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def damerau_levenshtein(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def normalized_damerau_levenshtein(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def osa_distance(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def generic_levenshtein(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def generic_damerau_levenshtein(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def generic_hamming(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def generic_jaro(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def generic_jaro_winkler(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end

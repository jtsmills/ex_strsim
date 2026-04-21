defmodule ExStrsim.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/jtsmills/ex_strsim"

  def project do
    [
      app: :ex_strsim,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "Fast string similarity metrics via Rust NIF (strsim crate).",
      source_url: @source_url,
      homepage_url: @source_url,
      docs: docs()
    ]
  end

  def application, do: [extra_applications: [:logger]]

  defp deps do
    [
      {:rustler, ">= 0.0.0", optional: true},
      {:rustler_precompiled, "~> 0.9"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "ExStrsim",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package do
    [
      files:
        ~w[lib native/ex_strsim_nif/src native/ex_strsim_nif/Cargo.* .formatter.exs mix.exs checksum-*.exs README.md LICENSE CHANGELOG.md],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end

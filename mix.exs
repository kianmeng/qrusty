defmodule Qrusty.MixProject do
  use Mix.Project

  @version "0.1.4"
  @source_url "https://github.com/nbw/qrusty"

  def project do
    [
      app: :qrusty,
      version: @version,
      github: @source_url,
      elixir: "~> 1.12",
      aliases: aliases(),
      start_permanent: Mix.env() == :prod,
      description: "QR Code library that leverages precompiled Rust",
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rustler_precompiled, "~> 0.4"},
      {:rustler, ">= 0.25.0", optional: true},

      # docs
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},

      # benchmarking
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_html, "~> 1.0", only: :dev},
      {:eqrcode, "~> 0.1.10", only: :dev},
      {:qr_code, "~> 2.3.1", only: :dev}
    ]
  end

  defp docs do
    [
      main: "Qrusty",
      assets: "assets",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native",
        "checksum-*.exs",
        "mix.exs",
        "LICENSE"
      ],
      exclude_patterns: [
        "native/qrusty/target"
      ],
      licenses: ["MIT"],
      maintainers: ["Nathan Willson"],
      links: %{"GitHub" => @source_url},
      source_url: @source_url
    ]
  end

  defp aliases do
    [
      "compile.local": &compile_local/1
    ]
  end

  defp compile_local(_) do
    Mix.shell().cmd("QRUSTY_BUILD=true mix compile")
  end
end

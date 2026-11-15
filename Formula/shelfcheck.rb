class Shelfcheck < Formula
  desc "Checks product feeds against the formats AI shopping assistants read, and flags identity changes between feeds"
  homepage "https://logitsolutions.ai/guides/ai-in-ecommerce/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/logitsolutionsai/shelfcheck/releases/download/v0.1.0/shelfcheck-aarch64-apple-darwin.tar.xz"
      sha256 "a11462314c61e6019b3b92bc26a60f0ae66953f8ba0aa1eaaa617b45d4365a8c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/logitsolutionsai/shelfcheck/releases/download/v0.1.0/shelfcheck-x86_64-apple-darwin.tar.xz"
      sha256 "14d099a6f326c80e6ebd56e875401d3df01bac86bd302a133ef728eba5f53fff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/logitsolutionsai/shelfcheck/releases/download/v0.1.0/shelfcheck-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0029afc22d37936aa63f198bd924b69996924df8b33fc50be1fffa5bb663b343"
    end
    if Hardware::CPU.intel?
      url "https://github.com/logitsolutionsai/shelfcheck/releases/download/v0.1.0/shelfcheck-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "575ce987b3b222c87ca7aa61b78a405f09ed3cc5321b837670fb78d53bc9112e"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "shelfcheck"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shelfcheck"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shelfcheck"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shelfcheck"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

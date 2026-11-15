class Promochaos < Formula
  desc "Throws thousands of generated carts at your discount code to find the carts that break it, then shrinks each one to the smallest cart that still breaks it."
  homepage "https://github.com/logitsolutionsai/promochaos"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/logitsolutionsai/promochaos/releases/download/v0.1.0/promochaos-aarch64-apple-darwin.tar.xz"
      sha256 "bd27c128eb7d941d042c83733cbb736ef84f3fe93b0bb7a86a8f4a395b35087c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/logitsolutionsai/promochaos/releases/download/v0.1.0/promochaos-x86_64-apple-darwin.tar.xz"
      sha256 "294ca662ff62cb1f9fd8c85bbfac92a300fe8a892262b86c10a4f69590ed4907"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/logitsolutionsai/promochaos/releases/download/v0.1.0/promochaos-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "630b0b810eedf43040ac351cb3997ff7740f7d38c966739bd88903555c7fc303"
    end
    if Hardware::CPU.intel?
      url "https://github.com/logitsolutionsai/promochaos/releases/download/v0.1.0/promochaos-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c382983e853ed00e2580501e8c51925df37f8fec2273d92d88b9e1e28fd0ab05"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "promochaos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "promochaos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "promochaos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "promochaos"
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

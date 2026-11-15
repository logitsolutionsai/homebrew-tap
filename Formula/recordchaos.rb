class Recordchaos < Formula
  desc "recordchaos: breaks synthetic patient record bundles (for HL7 FHIR R4) on purpose to test your importer, and shrinks every failure."
  homepage "https://github.com/logitsolutionsai/recordchaos#readme"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/logitsolutionsai/recordchaos/releases/download/v0.1.0/recordchaos-aarch64-apple-darwin.tar.xz"
      sha256 "8ccf2d5b39652657cfbbd1ed4f7628fd4d70fb3f2d93bddbedda3ebae3b14579"
    end
    if Hardware::CPU.intel?
      url "https://github.com/logitsolutionsai/recordchaos/releases/download/v0.1.0/recordchaos-x86_64-apple-darwin.tar.xz"
      sha256 "2772ef4ded7e00bf127c74032e17f3367240093075739b0c2cb75e8fd94ab10e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/logitsolutionsai/recordchaos/releases/download/v0.1.0/recordchaos-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c69d61ef561d16aa867cadcf17dbf454520b91ed398f0016a62b18fc3a9487c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/logitsolutionsai/recordchaos/releases/download/v0.1.0/recordchaos-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e79f65b4b743d99536a9598a6c0bf085e0bdaf20af10f811453a24bb6ebafa59"
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
      bin.install "recordchaos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "recordchaos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "recordchaos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "recordchaos"
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

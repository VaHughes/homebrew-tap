class Carrel < Formula
  desc "A quiet place to read your markdown."
  homepage "https://github.com/VaHughes/carrel"
  version "2026.10.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.10.21/carrel-aarch64-apple-darwin.tar.xz"
      sha256 "77c6e3b67ff9ede1fc6572604f6ad5f31b28eaed87c850462b2049acfeac6f6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.10.21/carrel-x86_64-apple-darwin.tar.xz"
      sha256 "a1c87a44d85cf23792e220cc75502076ddb5a9cabcaa18373300bbe3c42514a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.10.21/carrel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "829848f0f3e68b0f537e5e12357a76209d957e1c4808df5a555064e7a018f64b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.10.21/carrel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f50f2a151dbc7077114adf922a4b83045fbba6f20412509c330aba4488a94698"
    end
  end
  license all_of: [{ any_of: ["MIT", "Apache-2.0"] }, "MIT", "BSD-3-Clause", "FSFAP-no-warranty-disclaimer", "Knuth-CTAN"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "carrel"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "carrel"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "carrel"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "carrel"
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

class Carrel < Formula
  desc "A quiet place to read your markdown."
  homepage "https://github.com/VaHughes/carrel"
  version "2026.9.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.9.3/carrel-aarch64-apple-darwin.tar.xz"
      sha256 "93f50a56eb66cb9681685636bf64008d16d56495bb87b028cc737c2af21358eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.9.3/carrel-x86_64-apple-darwin.tar.xz"
      sha256 "d06f4c900fa2a44645fa5491521c1bc55c74eb35dd42339db4ff73605d74f457"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.9.3/carrel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58708e05350b4f4a52f9f14e5dfc834e850ec3054ad93b118f6449743cee056a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.9.3/carrel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1d95e55b0111978c7693a8b1b9fec73f4d80ae87654a0db72caaa8d2b3ebe7d1"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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

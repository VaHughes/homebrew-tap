class Carrel < Formula
  desc "A quiet place to read your markdown."
  homepage "https://github.com/VaHughes/carrel"
  version "2026.8.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.22/carrel-aarch64-apple-darwin.tar.xz"
      sha256 "12ab86abc28d7bee72865ccf2fe8969368ec2ae14bee021d085f8ea4fbc4732a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.22/carrel-x86_64-apple-darwin.tar.xz"
      sha256 "51c3f978ef0a66d700b74d4972b694d841b3fd8e64ca5add5f3585fcfdbc4429"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.22/carrel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b83b1176d552afc484dbfa72f42e872e72e970da65d5afe8f326f3e59398543f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.22/carrel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a71ae7aa0441f4f3a86e10f81b7bdb5981ccbf8f01ca26356bfa8dd94a5169a"
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

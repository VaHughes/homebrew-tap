class Carrel < Formula
  desc "A quiet place to read your markdown."
  homepage "https://github.com/VaHughes/carrel"
  version "2026.8.31"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.31/carrel-aarch64-apple-darwin.tar.xz"
      sha256 "72ac6d8e892586eb28510d0c6c6b921cd5b321724d6af604fe13c27964cfca07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.31/carrel-x86_64-apple-darwin.tar.xz"
      sha256 "ee84e67b4d34c883bc626403a2650d0ff706b68f1e1e3c6fa5b2e4354e7bf9e5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.31/carrel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2824c8406fb6e45da0491d33e94c938514316b00b27c6144b63dd2991cd8c0a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.8.31/carrel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba51c863bcb8f5404b58667a1c4a2ac627d92cfbfecab2f705292622f6735ef4"
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

class Carrel < Formula
  desc "A quiet place to read your markdown."
  homepage "https://github.com/VaHughes/carrel"
  version "2026.11.24"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.11.24/carrel-aarch64-apple-darwin.tar.xz"
      sha256 "afe6c65fdbc9a98e0b75d785ede0bd2ab0f6bc2a329aea989e0a6615e5883991"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.11.24/carrel-x86_64-apple-darwin.tar.xz"
      sha256 "377a3e4b5d6b3ee7b9bd9282d7a38bf0da8844a5a426fb10c368ff99c39041a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.11.24/carrel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "191fbeaedb8dab0ac6b2c8c927c19ca0bf0bd07f1ece31041e88821eb048e60a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/VaHughes/carrel/releases/download/v2026.11.24/carrel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "293a353a670e191ed9a5e869f9e2745c52513b9afd27e0dc72709553bc833064"
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

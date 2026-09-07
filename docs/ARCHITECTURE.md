# Architecture

- `Formula/carrel.rb` — the single Homebrew formula. It selects a prebuilt
  `carrel-<triple>.tar.xz` from the carrel GitHub release by OS and CPU
  (macOS/Linux, arm64/x86_64), pins the release version and per-archive
  sha256, and installs the `carrel` binary. Leftover archive files go to
  `pkgshare`.
- `README.md` — install instructions for humans.

Design decision: the formula is owned by cargo-dist in the carrel repo. Each
carrel release regenerates and force-pushes it here (one commit per version,
e.g. "carrel 2026.9.3"), so this repo is a publish target, not a place where
edits originate.

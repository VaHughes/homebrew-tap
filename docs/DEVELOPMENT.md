# Development

There is nothing to install, build, or test in this repo.

- Do not edit `Formula/carrel.rb` by hand; cargo-dist overwrites it at the
  next carrel release. Changes to the formula belong in carrel's dist config.
- To check the formula locally: `brew install vahughes/tap/carrel` or
  `brew audit --strict Formula/carrel.rb` (requires Homebrew).
- Releases arrive as commits titled `carrel <version>` pushed by the release
  workflow; do not rebase or rewrite them.

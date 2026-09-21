# homebrew-tap

Homebrew formulae for [meSingh](https://github.com/meSingh)'s tools. Works on macOS, and on Linux via Homebrew.

```bash
brew install meSingh/tap/polinrider-cleaner
polinrider
```

| Formula | What it is |
|---|---|
| [`polinrider-cleaner`](Formula/polinrider-cleaner.rb) | Detect and clean up after the PolinRider supply-chain campaign. Read-only by default. [Source](https://github.com/meSingh/polinrider-cleaner) |

| Cask | What it is |
|---|---|
| [`sukhi-play`](Casks/sukhi-play.rb) | A locked-down browser that opens only the websites a grown-up chose. For small children. [Source](https://github.com/meSingh/sukhi-play) |

```bash
brew install --cask meSingh/tap/sukhi-play
```

Sukhi Play is signed but not notarised, so macOS blocks the first launch and
the cask says how to allow it. That is also why it is here rather than in
homebrew/cask, which no longer accepts software Gatekeeper cannot verify.

Formulae install from the signed release tarballs, not a git checkout, and pin the release checksum.

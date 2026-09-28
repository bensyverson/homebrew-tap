# bensyverson/tap

Homebrew formulae for Ben Syverson's tools.

```bash
brew install bensyverson/tap/woodcase
```

| Formula | What it is |
|---|---|
| `woodcase` | Reads, edits, renders and generates SwiftUI and React code from [Pen](https://docs.pencil.dev/for-developers/the-pen-format) `.pen` design files. Builds from source; needs Xcode 26 or later. [Source](https://github.com/bensyverson/woodcase) |

## Releasing a new version

1. In Woodcase, set `WoodcaseVersion.current` (`Sources/WoodcaseCommandCore/Verbs/WoodcaseVersion.swift`) to the new version — the formula's test checks `woodcase --version` against it — then tag and push the tag (`git tag v0.2.0 && git push origin v0.2.0`).
2. Point the formula at it: `brew bump-formula-pr --url https://github.com/bensyverson/woodcase/archive/refs/tags/v0.2.0.tar.gz bensyverson/tap/woodcase`, or edit `url` and `sha256` by hand (`curl -sL <url> | shasum -a 256`).
3. Check it: `brew install --build-from-source bensyverson/tap/woodcase && brew test woodcase && brew audit --strict woodcase`.

## License

MIT

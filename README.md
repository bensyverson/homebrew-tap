# bensyverson/tap

Homebrew formulae for Ben Syverson's tools.

```bash
brew install bensyverson/tap/woodcase
```

| Formula | What it is |
|---|---|
| `woodcase` | Reads, edits, renders and generates SwiftUI and React code from [Pen](https://docs.pencil.dev/for-developers/the-pen-format) `.pen` design files. Builds from source; needs Xcode 26 or later. [Source](https://github.com/bensyverson/woodcase) |

## Releasing a new version

From a Woodcase checkout beside this one:

```bash
scripts/release 0.2.0        # bump, test, tag, push, update this formula, check it
scripts/release              # publish whatever WoodcaseVersion.current already says
scripts/release --dry-run    # print the plan, change nothing
```

Each step is skipped when already done, so a release that stopped halfway resumes by running it again. See `scripts/release --help` for the details.

## License

MIT

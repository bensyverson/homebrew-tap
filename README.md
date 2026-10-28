# bensyverson/tap

Homebrew formulae for Ben Syverson's tools.

```bash
brew install bensyverson/tap/woodcase
brew install bensyverson/tap/contextfill
```

| Formula | What it is |
|---|---|
| `woodcase` | Reads, edits, renders and generates SwiftUI and React code from [Pen](https://docs.pencil.dev/for-developers/the-pen-format) `.pen` design files. Pours a prebuilt bottle on Apple silicon (macOS 15+); elsewhere builds from source with Xcode 26 or later. [Source](https://github.com/bensyverson/woodcase) |
| `contextfill` | Tells a Claude Code or OpenCode session how full its context window is. Builds from source with Go; also installs the OpenCode plugin. [Source](https://github.com/bensyverson/contextfill) |

## Releasing a new version

Each tool releases itself. From its checkout beside this one:

```bash
scripts/release 0.2.0        # bump, test, tag, push, update this formula, check it
scripts/release              # publish whatever the source already says
scripts/release --dry-run    # print the plan, change nothing
```

A tool whose `scripts/release.conf` says `bottle=yes` also gets a prebuilt bottle, uploaded to its GitHub release, optionally signed (`sign=`) and notarized (`notary_profile=`).

Each step is skipped when already done, so a release that stopped halfway resumes by running it again. See `scripts/release --help` for the details.

## License

MIT

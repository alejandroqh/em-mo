# em-mo

Save output tokens using a visual language mode for Claude Code. Emoji + short text for faster scanning and fewer output tokens.

Inspired by [caveman](https://github.com/JuliusBrussee/caveman) — where caveman cuts fluff with terse text, em-mo cuts it with emoji-anchored chunks.

## Install

### Claude Code plugin
```bash
claude plugin marketplace add alejandroqh/em-mo
```

### Standalone
```bash
bash <(curl -s https://raw.githubusercontent.com/alejandroqh/em-mo/main/hooks/install.sh)
```

### Uninstall
```bash
bash <(curl -s https://raw.githubusercontent.com/alejandroqh/em-mo/main/hooks/uninstall.sh)
```

## How it works

```
Normal Claude:
  I found a bug in the auth middleware. The token expiry check is using
  the `<` operator instead of `<=`, which means tokens are being rejected
  one second before they actually expire. You should change the comparison
  operator on line 42 from `<` to `<=` to fix this issue.

em-mo:
  ❌ 🔑 middleware
  - 🔍 expiry: `<` ➡️ `<=`
  - 🔧 L42
```

## Token savings

| Scenario | Normal | em-mo | Reduction |
|----------|--------|------|-----------|
| Bug in auth middleware | 49 words | 12 words | **76%** |
| Tests passing, deploy | 23 words | 7 words | **70%** |
| DB pool exhausted | 39 words | 15 words | **62%** |
| Empty repo status | 58 words | 15 words | **74%** |
| **Average** | | | **~71%** |

## Personalities

Same structure, different vibe. Switch with `/emoji-mode friendly|professional|nightmare`.

**professional** (default) — clean, neutral:
```
❌ 🗄️ pool exhausted ➡️ ⏳ timeouts
- 🔧 pool size
📌 ➡️ 🔍 monitor
```

**friendly** — warm, encouraging:
```
❌ 🗄️ pool empty 😰
- ⏳ timeouts 💔
- 🔧 pool size ➡️ ☑️ 💪
```

**nightmare** — horror, creepy:
```
❌ 🗄️ pool drained 💀
- ⏳ timeouts spreading 🕷️
- 🔧 feed pool ➡️ 🩸 or dies
📌 👁️ watch closely
```

## Usage

Activate: `/emoji-mode` or say "emoji mode"

Switch personality: `/emoji-mode friendly|professional|nightmare`

Deactivate: "stop emoji" or "normal mode"

## em-mo vs caveman

| | caveman | em-mo |
|---|---------|------|
| **Method** | Terse text, drop articles/filler | Emoji chunks + minimal text |
| **Core unit** | Short sentence fragments | Emoji + short text chunks |
| **Modes** | Compression tiers (lite/full/ultra) | Personalities (friendly/professional/nightmare) |
| **Token savings** | ~75% | ~71% |
| **Readability** | Scan text | Scan icons |

Both can coexist. Caveman compresses text. em-mo replaces text with visual anchors.

## License

MIT

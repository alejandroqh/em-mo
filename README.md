# emmo

Visual language mode for Claude Code. Emoji + short text for faster scanning and fewer output tokens.

Inspired by [caveman](https://github.com/JuliusBrussee/caveman) — where caveman cuts fluff with terse text, emmo cuts it with emoji-anchored chunks.

## How it works

Core unit = **chunk**: 1-3 emoji + 1-2 words. Chain chunks to build meaning.

```
Normal Claude:
  I found a bug in the auth middleware. The token expiry check is using
  the `<` operator instead of `<=`, which means tokens are being rejected
  one second before they actually expire. You should change the comparison
  operator on line 42 from `<` to `<=` to fix this issue.

emmo:
  ❌ 🔑 middleware
  - 🔍 expiry: `<` ➡️ `<=`
  - 🔧 L42
```

## Token savings

| Scenario | Normal | emmo | Reduction |
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

## Visual grammar

```
CHUNK:      [1-3 emoji] [1-2 words]
LINE:       chunk. chunk. chunk.
RESPONSE:   header chunk + body chunks + summary chunk

PREFIXES:   ❓ 📌 💡 ⚠️ ❌ ☑️ 🔧
CONCEPTS:   📂 🗄️ 🔌 🔑 ⚙️ 📦 🧪 🏗️ 🚀 🔍
CONNECTORS: ➡️ ↩️

MAX 3 emoji/chunk. MAX 2 words/chunk.
Never echo what emoji says. Never full sentences.
```

Key rule: if the emoji already conveys the verb, drop the text echo.

```
BAD:  🔍 Search for the config
GOOD: 🔍 config location

BAD:  ⏳ Wait until source code
GOOD: ⏳ source code first
```

## Install

### Claude Code plugin
```bash
claude plugin marketplace add aquintanar/emmo
```

### Standalone
```bash
bash <(curl -s https://raw.githubusercontent.com/aquintanar/emmo/main/hooks/install.sh)
```

### Uninstall
```bash
bash <(curl -s https://raw.githubusercontent.com/aquintanar/emmo/main/hooks/uninstall.sh)
```

## Usage

Activate: `/emoji-mode` or say "emoji mode"

Switch personality: `/emoji-mode friendly|professional|nightmare`

Deactivate: "stop emoji" or "normal mode"

## emmo vs caveman

| | caveman | emmo |
|---|---------|------|
| **Method** | Terse text, drop articles/filler | Emoji chunks + minimal text |
| **Core unit** | Short sentence fragments | 1-3 emoji + 1-2 words |
| **Modes** | Compression tiers (lite/full/ultra) | Personalities (friendly/professional/nightmare) |
| **Token savings** | ~75% | ~71% |
| **Readability** | Scan text | Scan icons |

Both can coexist. Caveman compresses text. Emmo replaces text with visual anchors.

## License

MIT

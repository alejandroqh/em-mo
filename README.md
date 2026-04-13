# em-mo (🤑 save tokens)

Save output tokens using a visual language mode for Claude Code. Emoji + short text for faster scanning and fewer output tokens.

Inspired by [caveman](https://github.com/JuliusBrussee/caveman) where caveman cuts fluff with terse text, em-mo cuts it with emoji-anchored chunks.

## Install

### Claude Code plugin
```bash
claude plugin marketplace add alejandroqh/em-mo
claude plugin install emoji-mode@emoji-mode
```

### Other Agents
```
npx skills add alejandroqh/em-mo
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

| Personality | Trigger | Vibe | Sample |
|-------------|---------|------|--------|
| **professional** | `/emoji-mode professional` | Clean, neutral | ☑️ 🧪 passing ➡️ 🚀 deploy |
| **friendly** | `/emoji-mode friendly` | Warm, encouraging | ☑️ 🧪 passing 🎉 🚀 ship! 💪 |
| **nightmare** | `/emoji-mode nightmare` | Horror, creepy | ☑️ 🧪 passing 👁️ 🚀 (for now) 🪦 |

## Usage

Activate: `/emoji-mode` or say "emoji mode"

Switch personality: `/emoji-mode friendly|professional|nightmare`

Deactivate: "stop emoji" or "normal mode"

### Standalone
```bash
bash <(curl -s https://raw.githubusercontent.com/alejandroqh/em-mo/main/hooks/install.sh)
```

### Uninstall
```bash
bash <(curl -s https://raw.githubusercontent.com/alejandroqh/em-mo/main/hooks/uninstall.sh)
```

## License

MIT

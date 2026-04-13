#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
HOOKS_DIR="${CLAUDE_DIR}/hooks"
SKILLS_DIR="${CLAUDE_DIR}/skills/emoji-mode"
SETTINGS="${CLAUDE_DIR}/settings.json"

echo "Uninstalling emoji-mode..."

# Remove hook files
rm -f "${HOOKS_DIR}/emoji-activate.js"
rm -f "${HOOKS_DIR}/emoji-mode-tracker.js"

# Remove skill
rm -rf "$SKILLS_DIR"

# Remove flag file
rm -f "${CLAUDE_DIR}/.emoji-mode-active"

# Remove hooks from settings.json
if [ -f "$SETTINGS" ]; then
  node -e "
  const fs = require('fs');
  const settingsPath = '${SETTINGS}';
  let settings = {};
  try { settings = JSON.parse(fs.readFileSync(settingsPath, 'utf8')); } catch { process.exit(0); }
  if (!settings.hooks) process.exit(0);

  if (settings.hooks.SessionStart) {
    settings.hooks.SessionStart = settings.hooks.SessionStart.filter(h =>
      !JSON.stringify(h).includes('emoji-activate')
    );
    if (!settings.hooks.SessionStart.length) delete settings.hooks.SessionStart;
  }

  if (settings.hooks.UserPromptSubmit) {
    settings.hooks.UserPromptSubmit = settings.hooks.UserPromptSubmit.filter(h =>
      !JSON.stringify(h).includes('emoji-mode-tracker')
    );
    if (!settings.hooks.UserPromptSubmit.length) delete settings.hooks.UserPromptSubmit;
  }

  if (!Object.keys(settings.hooks).length) delete settings.hooks;
  fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
  "
fi

echo "emoji-mode uninstalled."

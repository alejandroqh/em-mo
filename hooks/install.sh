#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/alejandroqh/em-mo/main"
CLAUDE_DIR="${HOME}/.claude"
HOOKS_DIR="${CLAUDE_DIR}/hooks"
SKILLS_DIR="${CLAUDE_DIR}/skills/emoji-mode"
SETTINGS="${CLAUDE_DIR}/settings.json"

echo "Installing emoji-mode..."

# Create directories
mkdir -p "$HOOKS_DIR" "$SKILLS_DIR"

# Download hooks
curl -sL "${REPO_URL}/hooks/emoji-activate.js" -o "${HOOKS_DIR}/emoji-activate.js"
curl -sL "${REPO_URL}/hooks/emoji-mode-tracker.js" -o "${HOOKS_DIR}/emoji-mode-tracker.js"

# Download SKILL.md
curl -sL "${REPO_URL}/skills/emoji-mode/SKILL.md" -o "${SKILLS_DIR}/SKILL.md"

# Register hooks in settings.json
node -e "
const fs = require('fs');
const settingsPath = '${SETTINGS}';
let settings = {};
try { settings = JSON.parse(fs.readFileSync(settingsPath, 'utf8')); } catch {}
if (!settings.hooks) settings.hooks = {};

settings.hooks.SessionStart = settings.hooks.SessionStart || [];
const hasActivate = settings.hooks.SessionStart.some(h =>
  JSON.stringify(h).includes('emoji-activate')
);
if (!hasActivate) {
  settings.hooks.SessionStart.push({
    hooks: [{
      type: 'command',
      command: 'node ${HOOKS_DIR}/emoji-activate.js',
      timeout: 5,
      statusMessage: 'Loading emoji-mode...'
    }]
  });
}

settings.hooks.UserPromptSubmit = settings.hooks.UserPromptSubmit || [];
const hasTracker = settings.hooks.UserPromptSubmit.some(h =>
  JSON.stringify(h).includes('emoji-mode-tracker')
);
if (!hasTracker) {
  settings.hooks.UserPromptSubmit.push({
    hooks: [{
      type: 'command',
      command: 'node ${HOOKS_DIR}/emoji-mode-tracker.js',
      timeout: 5,
      statusMessage: 'Tracking emoji-mode...'
    }]
  });
}

fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
"

# Set default personality
echo "professional" > "${CLAUDE_DIR}/.emoji-mode-active"

echo ""
echo "emoji-mode installed!"
echo "  Restart Claude Code to activate."
echo "  Switch personality: /emoji-mode friendly|professional|nightmare"
echo "  Deactivate: \"stop emoji\" or \"normal mode\""

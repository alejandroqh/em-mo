#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const FLAG_FILE = path.join(
  process.env.HOME || process.env.USERPROFILE,
  ".claude",
  ".emoji-mode-active"
);

const SKILL_FILE = path.resolve(
  __dirname,
  "..",
  "skills",
  "emoji-mode",
  "SKILL.md"
);

function getActivePersonality() {
  try {
    if (fs.existsSync(FLAG_FILE)) {
      const content = fs.readFileSync(FLAG_FILE, "utf8").trim();
      if (["friendly", "professional", "nightmare"].includes(content)) {
        return content;
      }
    }
  } catch {}
  return "professional";
}

function loadSkill() {
  try {
    const content = fs.readFileSync(SKILL_FILE, "utf8");
    // Strip YAML frontmatter
    const stripped = content.replace(/^---[\s\S]*?---\n*/, "");
    return stripped;
  } catch (e) {
    return null;
  }
}

function main() {
  const personality = getActivePersonality();
  const skill = loadSkill();

  if (!skill) {
    process.exit(0);
  }

  // Ensure flag file exists
  const flagDir = path.dirname(FLAG_FILE);
  if (!fs.existsSync(flagDir)) {
    fs.mkdirSync(flagDir, { recursive: true });
  }
  fs.writeFileSync(FLAG_FILE, personality, "utf8");

  // Emit skill as session context
  const output = `EMOJI MODE ACTIVE. Personality: ${personality.toUpperCase()}. Rules:\n\n${skill}`;
  process.stdout.write(output);
}

main();

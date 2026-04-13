#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const FLAG_FILE = path.join(
  process.env.HOME || process.env.USERPROFILE,
  ".claude",
  ".emoji-mode-active"
);

const VALID_MODES = ["friendly", "professional", "nightmare"];

function main() {
  let input = "";
  process.stdin.setEncoding("utf8");
  process.stdin.on("data", (chunk) => (input += chunk));
  process.stdin.on("end", () => {
    try {
      const data = JSON.parse(input);
      const prompt = (data.prompt || data.message || "").trim().toLowerCase();

      // Check for mode switch: /emoji-mode <personality>
      const match = prompt.match(
        /^\/emoji-mode\s+(friendly|professional|nightmare)\s*$/
      );
      if (match) {
        const mode = match[1];
        const flagDir = path.dirname(FLAG_FILE);
        if (!fs.existsSync(flagDir)) {
          fs.mkdirSync(flagDir, { recursive: true });
        }
        fs.writeFileSync(FLAG_FILE, mode, "utf8");
        process.stdout.write(
          JSON.stringify({
            result: "continue",
            message: `Emoji-mode personality: ${mode.toUpperCase()}`,
          })
        );
        return;
      }

      // Check for deactivation
      if (
        prompt === "stop emoji" ||
        prompt === "normal mode" ||
        prompt === "stop emoji-mode"
      ) {
        try {
          fs.unlinkSync(FLAG_FILE);
        } catch {}
        process.stdout.write(
          JSON.stringify({
            result: "continue",
            message: "Emoji-mode deactivated.",
          })
        );
        return;
      }
    } catch {}

    // Default: pass through
    process.stdout.write(JSON.stringify({ result: "continue" }));
  });
}

main();

#!/usr/bin/env bash
set -e

echo "=== 1. Installing CLI Tools (RTK, Graphify & Strix) ==="
if [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v brew >/dev/null 2>&1; then
    brew install rtk
  else
    echo "Warning: Homebrew not found. Install RTK manually from https://github.com/rtk-ai/rtk"
  fi
else
  curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
fi

if command -v uv >/dev/null 2>&1; then
  uv tool install graphify
  uv tool install strix-agent
else
  echo "Warning: uv not found. Install uv (https://docs.astral.sh/uv/) to install Graphify and Strix."
fi

echo -e "\n=== 2. Installing Global AI Agent Skills ==="
SKILLS=(
  "anthropics/skills@frontend-design"
  "anthropics/skills@webapp-testing"
  "upstash/context7"
  "obra/superpowers"
  "mattpocock/skills"
  "DietrichGebert/ponytail"
  "usestrix/strix"
  "JuliusBrussee/caveman"
)

for skill in "${SKILLS[@]}"; do
  npx skills add "$skill" -g
done
npx impeccable install --scope=global

# Helper: Safely merge MCP entries into existing JSON configs via Python
merge_json_config() {
  local file_path="$1"
  local root_key="$2"
  local server_name="$3"
  local server_json="$4"

  mkdir -p "$(dirname "$file_path")"
  python3 - "$file_path" "$root_key" "$server_name" "$server_json" <<'PY'
import json, os, sys

file_path, root_key, server_name, server_json = sys.argv[1:5]
data = {}
if os.path.exists(file_path) and os.path.getsize(file_path) > 0:
    with open(file_path, "r", encoding="utf-8") as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError:
            data = {}

if root_key not in data or not isinstance(data[root_key], dict):
    data[root_key] = {}

data[root_key][server_name] = json.loads(server_json)

with open(file_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
PY
}

AGY_PATH="$HOME/.gemini/antigravity/mcp_config.json"
OC_PATH="$HOME/.config/opencode/opencode.json"
CONFIGURED_ANY=false

# Read from /dev/tty so interactive prompts work even when piped via `curl | bash`
if [ -r /dev/tty ]; then
  echo -e "\n=== 3. Optional UI MCP Setup ==="

  read -r -p "Configure 21st MCP (React/Tailwind UI components from 21st.dev)? [y/N]: " install_magic < /dev/tty
  if [[ "$install_magic" =~ ^[Yy]$ ]]; then
    read -r -p "Paste your 21st.dev API Key (from 21st.dev/settings/api-keys): " magic_key < /dev/tty
    if [[ -n "$magic_key" ]]; then
      merge_json_config "$AGY_PATH" "mcpServers" "magic" "{\"command\":\"npx\",\"args\":[\"-y\",\"@21st-dev/magic@latest\",\"API_KEY=$magic_key\"]}"
      merge_json_config "$OC_PATH" "mcp" "magic" "{\"type\":\"local\",\"command\":[\"npx\",\"-y\",\"@21st-dev/magic@latest\",\"API_KEY=$magic_key\"],\"enabled\":true}"
      echo "21st MCP merged into Antigravity & OpenCode!"
      CONFIGURED_ANY=true
    fi
  fi

  read -r -p "Configure MotionSites.ai MCP (animated web sections)? [y/N]: " install_motion < /dev/tty
  if [[ "$install_motion" =~ ^[Yy]$ ]]; then
    read -r -p "Paste your MotionSites.ai API Key (from motionsites.ai): " motion_key < /dev/tty
    if [[ -n "$motion_key" ]]; then
      merge_json_config "$AGY_PATH" "mcpServers" "motionsites" "{\"command\":\"npx\",\"args\":[\"-y\",\"@motionsites/mcp-server\"],\"env\":{\"MOTIONSITES_API_KEY\":\"$motion_key\"}}"
      merge_json_config "$OC_PATH" "mcp" "motionsites" "{\"type\":\"local\",\"command\":[\"npx\",\"-y\",\"@motionsites/mcp-server\"],\"environment\":{\"MOTIONSITES_API_KEY\":\"$motion_key\"},\"enabled\":true}"
      echo "MotionSites.ai MCP merged into Antigravity & OpenCode!"
      CONFIGURED_ANY=true
    fi
  fi

  if [ "$CONFIGURED_ANY" = true ]; then
    echo "For Zed: Add the snippet from README.md into your User settings.json under 'context_servers'."
  fi
fi

echo -e "\nAll done! Restart Zed, Antigravity, and OpenCode to load your devstyle setup."

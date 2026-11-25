#!/usr/bin/env bash
set -e

echo "=== Installing CLI Tools (RTK & Graphify) ==="
if [[ "$OSTYPE" == "darwin"* ]]; then
  brew install rtk
else
  curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
fi
uv tool install graphify

echo "=== Installing AI Agent Skills Globally ==="
SKILLS=(
  "anthropics/skills@frontend-design"
  "anthropics/skills@webapp-testing"
  "upstash/context7"
  "obra/superpowers"
  "mattpocock/skills"
  "DietrichGebert/ponytail"
  "cloudflare/security-audit-skill"
  "Leonxlnx/taste-skill"
  "nutlope/hallmark"
  "heydamir/unslop"
  "JuliusBrussee/caveman"
)

for skill in "${SKILLS[@]}"; do
  npx skills add "$skill" -g
done
npx impeccable install --scope=global

# Optional MotionSites.ai MCP Setup
read -r -p $'\nDo you want to configure MotionSites.ai MCP for Zed, Antigravity & OpenCode? [y/N]: ' install_mcp
if [[ "$install_mcp" =~ ^[Yy]$ ]]; then
  read -r -p "Paste your MotionSites.ai API Key (from motionsites.ai): " mcp_key

  # 1. Google Antigravity
  mkdir -p "$HOME/.gemini/antigravity"
  cat <<EOF > "$HOME/.gemini/antigravity/mcp_config.json"
{
  "mcpServers": {
    "motionsites": {
      "command": "npx",
      "args": ["-y", "@motionsites/mcp-server"],
      "env": { "MOTIONSITES_API_KEY": "$mcp_key" }
    }
  }
}
EOF

  # 2. OpenCode
  mkdir -p "$HOME/.config/opencode"
  cat <<EOF > "$HOME/.config/opencode/opencode.json"
{
  "mcp": {
    "motionsites": {
      "type": "local",
      "command": ["npx", "-y", "@motionsites/mcp-server"],
      "environment": { "MOTIONSITES_API_KEY": "$mcp_key" },
      "enabled": true
    }
  }
}
EOF

  echo "MotionSites MCP configured for Antigravity & OpenCode!"
  echo "For Zed: Open Settings -> AI -> MCP Servers and add @motionsites/mcp-server with MOTIONSITES_API_KEY."
fi

echo -e "\nAll done! Restart your IDEs to load the new skills."

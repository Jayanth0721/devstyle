# devstyle

> One-stop setup for high-efficiency AI coding skills across **Zed**, **Google Antigravity**, and **OpenCode** to boost agent performance, code quality, and UI design.

---

## Included Skills & Tools

| Category | Skill / Tool | Source | Purpose |
| :--- | :--- | :--- | :--- |
| **Token & Context** | **RTK** | `rtk-ai/rtk` | Compresses terminal output by 60–90% |
| **Token & Context** | **Caveman** | `JuliusBrussee/caveman` | Cuts agent output tokens by ~75% |
| **Token & Context** | **Graphify** | `Graphify-Labs/graphify` | Maps codebases into a queryable knowledge graph |
| **Workflow & Code** | **Superpowers** | `obra/superpowers` | Enforces brainstorm → plan → TDD → review workflows |
| **Workflow & Code** | **Matt Pocock's Skills** | `mattpocock/skills` | `grill-me`, TDD, PRD planning, and engineering workflows |
| **Workflow & Code** | **Ponytail** | `DietrichGebert/ponytail` | YAGNI & minimal-complexity senior engineer rules |
| **Security** | **Cloudflare Security Audit** | `cloudflare/security-audit-skill` | Multi-phase security audit with verified findings |
| **UI & Design** | **Frontend Design** | `anthropics/skills` | Anthropic's official high-craft frontend design skill |
| **UI & Design** | **Impeccable** | `pbakaus/impeccable` | Design vocabulary (`polish`, `audit`, `critique`) & 60+ checks |
| **UI & Design** | **Taste Skill** | `Leonxlnx/taste-skill` | Art direction, curated layouts, & browser visual verification |
| **UI & Design** | **Hallmark** | `nutlope/hallmark` | Anti-AI-slop themes + `sloplint` verification |
| **UI & Design** | **Unslop** | `heydamir/unslop` | Removes generic AI UI and copy patterns |

---

## Option 1: One-Line Automated Installer (Recommended)

Run the installer script for your OS to install the CLI tools (`rtk` and `graphify`), link all 10 skills globally across **Zed**, **Google Antigravity**, and **OpenCode**, and optionally configure **MotionSites.ai MCP**.

*(Replace `<YOUR_GITHUB_USERNAME>` with your GitHub username after pushing `install.ps1` and `install.sh` to your repo).*

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/Jayanth0721/devstyle/main/install.ps1 | iex
```

### macOS & Linux (Bash / Zsh)
```bash
curl -fsSL https://raw.githubusercontent.com/Jayanth0721/devstyle/main/install.sh | bash
```

---

## Option 2: Quick Import in Zed (Import from URL)

In **Zed**, open **Agent Settings → Skills → Import from URL** and paste any of these direct `.md` blob links:

* **Frontend Design (Anthropic):**
  `https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md`
* **Caveman (Output Compression):**
  `https://github.com/JuliusBrussee/caveman/blob/main/skills/caveman/SKILL.md`
* **Unslop (Anti-AI UI Polish):**
  `https://github.com/heydamir/unslop/blob/main/skills/unslop/SKILL.md`
* **RTK (Terminal Token Compressor):**
  `https://github.com/rtk-ai/rtk/blob/develop/CLAUDE.md`
* **Graphify (Codebase Graph):**
  `https://github.com/Graphify-Labs/graphify/blob/v8/graphify/skill.md`

*(Note: For **RTK** and **Graphify**, also install their CLI binaries below so Zed's terminal tool can execute them).*

---

## Option 3: Manual Multi-IDE Setup (Windows, macOS, Linux)

### Prerequisites
* **Node.js 18+** (for `npx skills`)
* **Python 3.11+ & `uv`** (only needed for Graphify)

### Windows (PowerShell)
```powershell
winget install rtk-ai.rtk
uv tool install graphify

npx skills add anthropics/skills@frontend-design -g
npx skills add obra/superpowers -g
npx skills add mattpocock/skills -g
npx skills add DietrichGebert/ponytail -g
npx skills add cloudflare/security-audit-skill -g
npx skills add Leonxlnx/taste-skill -g
npx skills add nutlope/hallmark -g
npx skills add heydamir/unslop -g
npx skills add JuliusBrussee/caveman -g
npx impeccable install --scope=global
```

### macOS (Terminal / Homebrew)
```bash
brew install rtk
uv tool install graphify

npx skills add anthropics/skills@frontend-design -g
npx skills add obra/superpowers -g
npx skills add mattpocock/skills -g
npx skills add DietrichGebert/ponytail -g
npx skills add cloudflare/security-audit-skill -g
npx skills add Leonxlnx/taste-skill -g
npx skills add nutlope/hallmark -g
npx skills add heydamir/unslop -g
npx skills add JuliusBrussee/caveman -g
npx impeccable install --scope=global
```

### Linux (Bash / Zsh)
```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
uv tool install graphify

npx skills add anthropics/skills@frontend-design -g
npx skills add obra/superpowers -g
npx skills add mattpocock/skills -g
npx skills add DietrichGebert/ponytail -g
npx skills add cloudflare/security-audit-skill -g
npx skills add Leonxlnx/taste-skill -g
npx skills add nutlope/hallmark -g
npx skills add heydamir/unslop -g
npx skills add JuliusBrussee/caveman -g
npx impeccable install --scope=global
```

---

## Optional: MotionSites.ai MCP Setup

During the automated install (`install.ps1` / `install.sh`), choose **`y`** when prompted to automatically configure **MotionSites.ai MCP** for **Google Antigravity** and **OpenCode**.

### Adding MotionSites.ai MCP to Zed
To add it to **Zed** without overwriting your existing settings, open your User `settings.json` (`Ctrl+Shift+P` → `zed: open settings file`) and add this block at the top level:

```json
"context_servers": {
  "motionsites": {
    "command": "npx",
    "args": ["-y", "@motionsites/mcp-server"],
    "env": {
      "MOTIONSITES_API_KEY": "YOUR_MOTIONSITES_API_KEY"
    }
  }
}
```

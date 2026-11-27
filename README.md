# devstyle

> One-stop setup for high-efficiency **Agent Skills (`SKILL.md`)**, CLI token compressors, and UI/Security MCPs across **Zed**, **Google Antigravity**, and **OpenCode**.

---

## Included Skills & Tools (11 Core + 2 Optional MCPs)

| Sl. No. | Category | Skill / Tool | Source / Package | Purpose |
| :---: | :--- | :--- | :--- | :--- |
| 1 | **Token & Context** | **RTK** *(CLI)* | `rtk-ai/rtk` | Compresses terminal output by 60–90% |
| 2 | **Token & Context** | **Caveman** | `JuliusBrussee/caveman` | Cuts agent output tokens by ~75% |
| 3 | **Token & Context** | **Graphify** *(CLI + Skill)* | `Graphify-Labs/graphify` | Maps codebases into a queryable knowledge graph |
| 4 | **Token & Context** | **Context7** | `upstash/context7` | Fetches live, version-accurate library documentation |
| 5 | **Workflow & Code** | **Superpowers** | `obra/superpowers` | Enforces spec → plan → TDD → review workflows |
| 6 | **Workflow & Code** | **Matt Pocock's Skills** | `mattpocock/skills` | `grill-me`, TDD, PRD planning, and engineering workflows |
| 7 | **Workflow & Code** | **Ponytail** | `DietrichGebert/ponytail` | YAGNI & minimal-complexity senior engineer rules |
| 8 | **Testing & QA** | **Webapp Testing** | `anthropics/skills` | Automated browser UI testing & visual verification |
| 9 | **Security** | **Strix** *(CLI + Skills)* | `usestrix/strix` | Autonomous dynamic penetration testing & vulnerability fixes |
| 10 | **UI & Design** | **Frontend Design** | `anthropics/skills` | Anthropic's official high-craft frontend design skill |
| 11 | **UI & Design** | **Impeccable** | `pbakaus/impeccable` | Design vocabulary (`audit`, `polish`, `critique`) & 62-rule anti-slop detector |
| 12 | **UI MCP** *(Opt.)* | **21st MCP** | `@21st-dev/magic` | Fetches & generates modern React/Tailwind UI components |
| 13 | **UI MCP** *(Opt.)* | **MotionSites.ai MCP** | `@motionsites/mcp-server` | Animated web sections & landing-page primitives |

---

## Option 1: One-Line Automated Installer (Recommended)

Installs the CLI tools (`rtk`, `graphify`, `strix`), links all **9 global Agent Skill packs** across **Zed**, **Google Antigravity**, and **OpenCode**, and safely merges **21st MCP** and/or **MotionSites.ai MCP** into your existing config files without overwriting them.

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
* **Webapp Testing (Anthropic):**
  `https://github.com/anthropics/skills/blob/main/skills/webapp-testing/SKILL.md`
* **Caveman (Output Compression):**
  `https://github.com/JuliusBrussee/caveman/blob/main/skills/caveman/SKILL.md`
* **RTK (Terminal Token Compressor):**
  `https://github.com/rtk-ai/rtk/blob/develop/CLAUDE.md`
* **Graphify (Codebase Graph):**
  `https://github.com/Graphify-Labs/graphify/blob/v8/graphify/skill.md`

*(Note: For **RTK**, **Graphify**, and **Strix**, also install their CLI binaries below so Zed's terminal tool can execute them).*

---

## Option 3: Manual Multi-IDE Setup (Windows, macOS, Linux)

### Prerequisites
* **Node.js 18+** (for `npx skills` and MCP servers)
* **Python 3.11+ & `uv`** (for `graphify` and `strix`)
* **Docker** *(optional, required only when running local `strix` security sandboxes)*

### Windows (PowerShell)
```powershell
winget install rtk-ai.rtk
uv tool install graphify
uv tool install strix-agent

npx skills add anthropics/skills@frontend-design -g
npx skills add anthropics/skills@webapp-testing -g
npx skills add upstash/context7 -g
npx skills add obra/superpowers -g
npx skills add mattpocock/skills -g
npx skills add DietrichGebert/ponytail -g
npx skills add usestrix/strix -g
npx skills add JuliusBrussee/caveman -g
npx impeccable install --scope=global
```

### macOS (Terminal / Homebrew)
```bash
brew install rtk
uv tool install graphify
uv tool install strix-agent

npx skills add anthropics/skills@frontend-design -g
npx skills add anthropics/skills@webapp-testing -g
npx skills add upstash/context7 -g
npx skills add obra/superpowers -g
npx skills add mattpocock/skills -g
npx skills add DietrichGebert/ponytail -g
npx skills add usestrix/strix -g
npx skills add JuliusBrussee/caveman -g
npx impeccable install --scope=global
```

### Linux (Bash / Zsh)
```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
uv tool install graphify
uv tool install strix-agent

npx skills add anthropics/skills@frontend-design -g
npx skills add anthropics/skills@webapp-testing -g
npx skills add upstash/context7 -g
npx skills add obra/superpowers -g
npx skills add mattpocock/skills -g
npx skills add DietrichGebert/ponytail -g
npx skills add usestrix/strix -g
npx skills add JuliusBrussee/caveman -g
npx impeccable install --scope=global
```

---

## Optional: UI MCP Setup (21st MCP & MotionSites.ai)

During the automated install (`install.ps1` / `install.sh`), choose **`y`** when prompted to automatically merge **21st MCP** and/or **MotionSites.ai MCP** into **Google Antigravity** (`~/.gemini/antigravity/mcp_config.json`) and **OpenCode** (`~/.config/opencode/opencode.json`).

### Adding to Zed (`settings.json`)
Open User `settings.json` (`Ctrl+Shift+P` → `zed: open settings file`) and add your chosen server(s) under `"context_servers"`:

```json
"context_servers": {
  "magic": {
    "command": "npx",
    "args": ["-y", "@21st-dev/magic@latest", "API_KEY=YOUR_21ST_DEV_API_KEY"]
  },
  "motionsites": {
    "command": "npx",
    "args": ["-y", "@motionsites/mcp-server"],
    "env": {
      "MOTIONSITES_API_KEY": "YOUR_MOTIONSITES_API_KEY"
    }
  }
}
```

---

## Quick Verification & Trigger Cheat Sheet

| Sl. No. | Tool / Skill | How to Trigger / Verify | What It Does |
| :---: | :--- | :--- | :--- |
| 1 | **RTK** | Run `rtk gain` in terminal | Shows token compression savings |
| 2 | **Caveman** | Type `/caveman` or `/ultracave` in chat | Switches replies to ultra-terse mode |
| 3 | **Graphify** | Run `/graphify .` in your repo | Builds and queries your codebase graph |
| 4 | **Context7** | Ask agent to *"use context7 docs for..."* | Pulls live, version-accurate library docs |
| 5 | **Superpowers** | Ask agent to *"brainstorm and plan..."* | Enforces spec → plan → TDD → review |
| 6 | **Matt Pocock** | Ask agent to `grill-me` on your plan | Stress-tests architecture & edge cases |
| 7 | **Ponytail** | Active automatically on code edits | Enforces YAGNI & minimal complexity |
| 8 | **Webapp Testing** | Ask agent to *"test the running app in browser"* | Launches browser checks & screenshots |
| 9 | **Strix** | Run `strix -t ./` or ask for a security scan | Runs dynamic autonomous vulnerability checks |
| 10 | **Frontend Design** | Ask agent to *"build a landing page / UI..."* | Generates high-craft, non-generic layouts |
| 11 | **Impeccable** | Ask agent to `audit`, `polish`, or `critique` UI | Runs 62-rule anti-slop & UI/UX craft checks |
| 12 | **21st MCP** | Type `/ui <component description>` in chat | Fetches modern React/Tailwind components |

---

## Author
* **Jayanth** — [@Jayanth0721](https://github.com/Jayanth0721)

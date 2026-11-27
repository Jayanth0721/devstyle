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
irm [https://raw.githubusercontent.com/Jayanth0721/devstyle/main/install.ps1](https://raw.githubusercontent.com/Jayanth0721/devstyle/main/install.ps1) | iex

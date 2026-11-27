---

### 2. `install.ps1`

```powershell
$ErrorActionPreference = "Stop"

Write-Host "=== 1. Installing CLI Tools (RTK, Graphify & Strix) ===" -ForegroundColor Cyan
if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install rtk-ai.rtk --accept-package-agreements --accept-source-agreements
} else {
    Write-Warning "winget not found. Install RTK manually from https://github.com/rtk-ai/rtk"
}

if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv tool install graphify
    uv tool install strix-agent
} else {
    Write-Warning "uv not found. Install uv (https://docs.astral.sh/uv/) to install Graphify and Strix."
}

Write-Host "`n=== 2. Installing Global AI Agent Skills ===" -ForegroundColor Cyan
$skills = @(
    "anthropics/skills@frontend-design",
    "anthropics/skills@webapp-testing",
    "upstash/context7",
    "obra/superpowers",
    "mattpocock/skills",
    "DietrichGebert/ponytail",
    "usestrix/strix",
    "JuliusBrussee/caveman"
)

foreach ($s in $skills) {
    npx skills add $s -g
}
npx impeccable install --scope=global

# Helper: Safely merge MCP entries into existing JSON configs without overwriting
function Merge-JsonConfig {
    param (
        [string]$FilePath,
        [string]$RootKey,
        [string]$ServerName,
        [hashtable]$ServerConfig
    )
    $dir = Split-Path -Parent $FilePath
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }

    if (Test-Path $FilePath) {
        $raw = Get-Content $FilePath -Raw
        $json = if ([string]::IsNullOrWhiteSpace($raw)) { @{} } else { $raw | ConvertFrom-Json -AsHashtable }
    } else {
        $json = @{}
    }

    if (-not $json.ContainsKey($RootKey) -or $null -eq $json[$RootKey]) {
        $json[$RootKey] = @{}
    }
    $json[$RootKey][$ServerName] = $ServerConfig
    $json | ConvertTo-Json -Depth 10 | Set-Content -Path $FilePath -Encoding UTF8
}

$agyPath = "$env:USERPROFILE\.gemini\antigravity\mcp_config.json"
$ocPath  = "$env:USERPROFILE\.config\opencode\opencode.json"

Write-Host "`n=== 3. Optional UI MCP Setup ===" -ForegroundColor Cyan

# Option A: 21st MCP
$installMagic = Read-Host "Configure 21st MCP (React/Tailwind UI components from 21st.dev)? [y/N]"
if ($installMagic -match "^[Yy]$") {
    $magicKey = Read-Host "Paste your 21st.dev API Key (from 21st.dev/settings/api-keys)"
    if (-not [string]::IsNullOrWhiteSpace($magicKey)) {
        Merge-JsonConfig -FilePath $agyPath -RootKey "mcpServers" -ServerName "magic" -ServerConfig @{
            command = "npx"
            args    = @("-y", "@21st-dev/magic@latest", "API_KEY=$magicKey")
        }
        Merge-JsonConfig -FilePath $ocPath -RootKey "mcp" -ServerName "magic" -ServerConfig @{
            type    = "local"
            command = @("npx", "-y", "@21st-dev/magic@latest", "API_KEY=$magicKey")
            enabled = $true
        }
        Write-Host "21st MCP merged into Antigravity & OpenCode!" -ForegroundColor Green
    }
}

# Option B: MotionSites.ai MCP
$installMotion = Read-Host "Configure MotionSites.ai MCP (animated web sections)? [y/N]"
if ($installMotion -match "^[Yy]$") {
    $motionKey = Read-Host "Paste your MotionSites.ai API Key (from motionsites.ai)"
    if (-not [string]::IsNullOrWhiteSpace($motionKey)) {
        Merge-JsonConfig -FilePath $agyPath -RootKey "mcpServers" -ServerName "motionsites" -ServerConfig @{
            command = "npx"
            args    = @("-y", "@motionsites/mcp-server")
            env     = @{ MOTIONSITES_API_KEY = $motionKey }
        }
        Merge-JsonConfig -FilePath $ocPath -RootKey "mcp" -ServerName "motionsites" -ServerConfig @{
            type        = "local"
            command     = @("npx", "-y", "@motionsites/mcp-server")
            environment = @{ MOTIONSITES_API_KEY = $motionKey }
            enabled     = $true
        }
        Write-Host "MotionSites.ai MCP merged into Antigravity & OpenCode!" -ForegroundColor Green
    }
}

if (($installMagic -match "^[Yy]$") -or ($installMotion -match "^[Yy]$")) {
    Write-Host "For Zed: Add the snippet from README.md into your User settings.json under 'context_servers'." -ForegroundColor Yellow
}

Write-Host "`nAll done! Restart Zed, Antigravity, and OpenCode to load your devstyle setup." -ForegroundColor Green

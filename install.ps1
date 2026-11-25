Write-Host "=== Installing CLI Tools (RTK & Graphify) ===" -ForegroundColor Cyan
winget install rtk-ai.rtk --accept-package-agreements --accept-source-agreements
uv tool install graphify

Write-Host "`n=== Installing AI Agent Skills Globally ===" -ForegroundColor Cyan
$skills = @(
    "anthropics/skills@frontend-design",
    "obra/superpowers",
    "mattpocock/skills",
    "DietrichGebert/ponytail",
    "cloudflare/security-audit-skill",
    "Leonxlnx/taste-skill",
    "nutlope/hallmark",
    "heydamir/unslop",
    "JuliusBrussee/caveman"
)
foreach ($s in $skills) {
    npx skills add $s -g
}
npx impeccable install --scope=global

# Optional MotionSites.ai MCP Setup
$installMcp = Read-Host "`nDo you want to configure MotionSites.ai MCP for Zed, Antigravity & OpenCode? [y/N]"
if ($installMcp -match "^[Yy]$") {
    $mcpKey = Read-Host "Paste your MotionSites.ai API Key (from motionsites.ai)"
    
    # 1. Google Antigravity (~/.gemini/antigravity/mcp_config.json)
    $agyDir = "$env:USERPROFILE\.gemini\antigravity"
    New-Item -ItemType Directory -Force -Path $agyDir | Out-Null
    $agyMcp = @{
        mcpServers = @{
            motionsites = @{
                command = "npx"
                args = @("-y", "@motionsites/mcp-server")
                env = @{ MOTIONSITES_API_KEY = $mcpKey }
            }
        }
    } | ConvertTo-Json -Depth 5
    Set-Content -Path "$agyDir\mcp_config.json" -Value $agyMcp

    # 2. OpenCode (~/.config/opencode/opencode.json)
    $ocDir = "$env:USERPROFILE\.config\opencode"
    New-Item -ItemType Directory -Force -Path $ocDir | Out-Null
    $ocConfig = @{
        mcp = @{
            motionsites = @{
                type = "local"
                command = @("npx", "-y", "@motionsites/mcp-server")
                environment = @{ MOTIONSITES_API_KEY = $mcpKey }
                enabled = $true
            }
        }
    } | ConvertTo-Json -Depth 5
    Set-Content -Path "$ocDir\opencode.json" -Value $ocConfig

    Write-Host "MotionSites MCP configured for Antigravity & OpenCode!" -ForegroundColor Green
    Write-Host "For Zed: Open Settings -> AI -> MCP Servers and add @motionsites/mcp-server with MOTIONSITES_API_KEY." -ForegroundColor Yellow
}

Write-Host "`nAll done! Restart your IDEs to load the new skills." -ForegroundColor Green

$ErrorActionPreference = "Stop"

$RootDir = $PSScriptRoot
$AllSources = "https://github.com/Egormity, https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro"
$EgormitySource = "https://github.com/Egormity"
$RuyouSources = "https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro"

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Label,
        [Parameter(Mandatory = $true)]
        [scriptblock] $Command
    )

    Write-Host ""
    Write-Host "> $Label"
    & $Command

    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}

if (-not (Get-Command egormity_git_tools -ErrorAction SilentlyContinue)) {
    Write-Error "egormity_git_tools was not found in PATH."
}

Push-Location $RootDir
try {
    Invoke-Step "Generate all docs" {
        egormity_git_tools generate_agents $AllSources ./
    }

    Invoke-Step "Clone Egormity repositories" {
        egormity_git_tools clone_all $EgormitySource
    }

    Invoke-Step "Generate Egormity AGENTS.md files" {
        egormity_git_tools generate_agents $EgormitySource ./egormity
    }

    Invoke-Step "Clone RuYou repositories" {
        egormity_git_tools clone_all $RuyouSources ruyou
    }

    Invoke-Step "Generate RuYou workspace AGENTS.md files" {
        egormity_git_tools generate_agents $RuyouSources ruyou
    }

    Push-Location ruyou
    try {
        Invoke-Step "Generate ruyou AGENTS.md files" {
            egormity_git_tools generate_agents "https://gitlab.com/ruyou"
        }

        Invoke-Step "Generate mihrjakovsv AGENTS.md files" {
            egormity_git_tools generate_agents "https://gitlab.com/mihrjakovsv"
        }

        Invoke-Step "Generate black_ruyou AGENTS.md files" {
            egormity_git_tools generate_agents "https://gitlab.com/black_ruyou"
        }

        Invoke-Step "Generate timecapspro AGENTS.md files" {
            egormity_git_tools generate_agents "https://github.com/timecapspro"
        }
    }
    finally {
        Pop-Location
    }
}
finally {
    Pop-Location
}

$ErrorActionPreference = "Stop"

$RootDir = $PSScriptRoot
$EgormitySource = "https://github.com/Egormity"
$RuyouSources = @(
    "https://gitlab.com/ruyou",
    "https://gitlab.com/mihrjakovsv",
    "https://gitlab.com/black_ruyou",
    "https://github.com/timecapspro"
)
$AllSources = @($EgormitySource) + $RuyouSources
$SkippedSources = New-Object System.Collections.Generic.List[string]
$ProbeDir = Join-Path ([System.IO.Path]::GetTempPath()) "egormity_git_tools_probe_$([System.Guid]::NewGuid())"

function Join-Sources {
    param(
        [Parameter(Mandatory = $true)]
        [string[]] $Sources
    )

    return ($Sources -join ", ")
}

function Test-SourceAccess {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Source
    )

    & egormity_git_tools get_account_info $Source "account.json" $ProbeDir *> $null
    return ($LASTEXITCODE -eq 0)
}

function Invoke-OptionalStep {
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
        Write-Warning "Skipped failed step: $Label"
        $global:LASTEXITCODE = 0
        return $false
    }

    return $true
}

if (-not (Get-Command egormity_git_tools -ErrorAction SilentlyContinue)) {
    Write-Error "egormity_git_tools was not found in PATH."
}

New-Item -ItemType Directory -Force -Path $ProbeDir | Out-Null

Push-Location $RootDir
try {
    $AccessibleSources = @()

    foreach ($Source in $AllSources) {
        Write-Host ""
        Write-Host "> Check access: $Source"

        if (Test-SourceAccess $Source) {
            $AccessibleSources += $Source
            Write-Host "Accessible"
        }
        else {
            $SkippedSources.Add($Source)
            Write-Warning "Skipping inaccessible namespace: $Source"
        }
    }

    if ($AccessibleSources.Count -eq 0) {
        Write-Warning "No accessible namespaces found; nothing to do."
        exit 0
    }

    Invoke-OptionalStep "Generate all docs" {
        egormity_git_tools generate_agents (Join-Sources $AccessibleSources) ./
    } | Out-Null

    if ($AccessibleSources -contains $EgormitySource) {
        Invoke-OptionalStep "Clone Egormity repositories" {
            egormity_git_tools clone_all $EgormitySource
        } | Out-Null

        Invoke-OptionalStep "Generate Egormity AGENTS.md files" {
            egormity_git_tools generate_agents $EgormitySource ./egormity
        } | Out-Null
    }

    $AccessibleRuyouSources = @($RuyouSources | Where-Object { $AccessibleSources -contains $_ })

    if ($AccessibleRuyouSources.Count -gt 0) {
        Invoke-OptionalStep "Clone RuYou repositories" {
            egormity_git_tools clone_all (Join-Sources $AccessibleRuyouSources) ruyou
        } | Out-Null

        Invoke-OptionalStep "Generate RuYou workspace AGENTS.md files" {
            egormity_git_tools generate_agents (Join-Sources $AccessibleRuyouSources) ruyou
        } | Out-Null

        if (Test-Path -Path "ruyou" -PathType Container) {
            Push-Location ruyou
            try {
                foreach ($Source in $AccessibleRuyouSources) {
                    Invoke-OptionalStep "Generate $Source AGENTS.md files" {
                        egormity_git_tools generate_agents $Source
                    } | Out-Null
                }
            }
            finally {
                Pop-Location
            }
        }
        else {
            Write-Warning "Skipping per-namespace RuYou AGENTS.md files because the ruyou folder does not exist."
        }
    }

    if ($SkippedSources.Count -gt 0) {
        Write-Host ""
        Write-Host "Skipped inaccessible namespaces:"
        foreach ($Source in $SkippedSources) {
            Write-Host "- $Source"
        }
    }
}
finally {
    Pop-Location
    if (Test-Path -Path $ProbeDir) {
        Remove-Item -LiteralPath $ProbeDir -Recurse -Force
    }
}

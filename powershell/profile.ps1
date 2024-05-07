## Install Posh-Git on first load
if (-not (Get-Module -ListAvailable -Name posh-git)) {
    Write-Host "posh-git module not found. Attempting to install..." -ForegroundColor Yellow
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    
    if ($?) {
        Write-Host "posh-git module installed successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to install posh-git module." -ForegroundColor Red
    }
}

# Load Posh Git 
Import-Module posh-git
$GitPromptSettings.DefaultPromptPath = '$(Get-PromptPath | Split-Path -Leaf)' # Current Folder Only

# Miniconda
## This is used to show the current conda environment
(& "C:\tools\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
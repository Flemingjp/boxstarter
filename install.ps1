## Start By Moving Into Users Space
cd $env:USERPROFILE

## Choco Packages
choco install git
choco install gpg4win
choco install powershell-core
choco install microsoft-windows-terminal
choco install gsudo
choco install ffmpeg
choco install firefox
choco install miniconda3 --params="'/InstallationType:JustMe /AddToPath:1'"
choco install spotify
choco install vlc
choco install 7zip
choco install gimp
choco install inkscape
choco install vscode

## Clone Repo
git clone https://github.com/Flemingjp/boxstarter.git

## Activate conda
conda init

## Install conda environments
foreach ($yamlFile in Get-ChildItem -Path "./conda" -Filter "*.yml") {
    # Install Conda environment from the YAML file
    $process = Start-Process -FilePath "conda" -ArgumentList "env create -f `"$($yamlFile.FullName)`"" -PassThru -Wait -NoNewWindow

    # Check the exit code of the process
    if ($process.ExitCode -eq 0) {
        Write-Host "Environment created successfully from $($yamlFile.Name)" -ForegroundColor Green
    } else {
        Write-Host "Failed to create environment from $($yamlFile.Name)" -ForegroundColor Red
    }
}

## Install Powershell profile
Copy-Item -Path "./powershell/profile.ps1" -Destination $PROFILE -Force

## Reg Edits
# File Explorer: Shows file extensions
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
Write-Host "Reg Edit: File Explorer - show file extensions" -ForegroundColor Green
# setup.ps1

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

$ToolsDir = Join-Path $Root "tools"
$ConfigsDir = Join-Path $Root "configs"
$LogsDir = Join-Path $Root "logs"

$NotepadInstaller = Join-Path $ToolsDir "notepad.exe"
$TCPViewerInstaller = Join-Path $ToolsDir "TCPViewer.exe"

Write-Host "Starting Straiker.ai workstation setup..."

$RequiredDirs = @(
    $ToolsDir,
    $ConfigsDir,
    (Join-Path $ConfigsDir "notepad"),
    (Join-Path $ConfigsDir "TCPViewer"),
    $LogsDir,
    (Join-Path $LogsDir "notepad-logs"),
    (Join-Path $LogsDir "TCPViewer-logs")
)

foreach ($Dir in $RequiredDirs) {
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
}

if (Test-Path $NotepadInstaller) {
    Write-Host "Installing Notepad..."
    Start-Process -FilePath $NotepadInstaller -ArgumentList "/SILENT" -Wait
} else {
    Write-Host "Missing installer: tools\notepad.exe"
}

if (Test-Path $TCPViewerInstaller) {
    Write-Host "Running TCPViewer..."
    Start-Process -FilePath $TCPViewerInstaller -ArgumentList "/accepteula" -Wait
} else {
    Write-Host "Missing installer: tools\TCPViewer.exe"
}

@"
Straiker.ai Workstation Setup
Date: $(Get-Date)
Root: $Root
Status: Completed
"@ | Out-File -FilePath (Join-Path $LogsDir "setup.log") -Encoding UTF8

Write-Host "Setup completed."

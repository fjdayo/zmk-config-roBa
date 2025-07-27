# roBa Keyboard Documentation Auto-Update Script
# PowerShell script to automatically update documentation when config files change

param(
    [string]$ConfigFile,
    [switch]$Force,
    [switch]$AutoPush
)

# Set encoding to UTF-8
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Define paths
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$DocsPath = Join-Path $ProjectRoot "docs\roBa-keyboard-settings.md"
$KeymapPath = Join-Path $ProjectRoot "config\roBa.keymap"
$JsonPath = Join-Path $ProjectRoot "config\roBa.json"

Write-Host "roBa キーボード ドキュメント自動更新スクリプト" -ForegroundColor Green

# Function to extract layer information from keymap
function Get-LayerInfo {
    param([string]$KeymapFile)
    
    $content = Get-Content $KeymapFile -Encoding UTF8
    $layers = @{}
    $currentLayer = $null
    $inBindings = $false
    
    foreach ($line in $content) {
        if ($line -match '^\s*(\w+)\s*\{') {
            $currentLayer = $matches[1]
            $layers[$currentLayer] = @{
                Name = $currentLayer
                Bindings = @()
            }
        }
        
        if ($line -match 'bindings\s*=\s*<') {
            $inBindings = $true
        }
        
        if ($inBindings -and $line -match '>;') {
            $inBindings = $false
        }
        
        if ($inBindings -and $currentLayer -and $line.Trim() -ne "" -and -not ($line -match 'bindings\s*=')) {
            $layers[$currentLayer].Bindings += $line.Trim()
        }
    }
    
    return $layers
}

# Function to extract hardware info
function Get-HardwareInfo {
    param([string]$JsonFile)
    
    if (Test-Path $JsonFile) {
        $json = Get-Content $JsonFile -Encoding UTF8 | ConvertFrom-Json
        return $json
    }
    return $null
}

# Function to update documentation
function Update-Documentation {
    param(
        [hashtable]$LayerInfo,
        [object]$HardwareInfo
    )
    
    Write-Host "ドキュメントを更新中..." -ForegroundColor Yellow
    
    # Read current documentation
    $docContent = Get-Content $DocsPath -Encoding UTF8
    
    # Update timestamp in change history
    $timestamp = Get-Date -Format "yyyy年MM月dd日 HH:mm"
    $updateNote = "#### 自動更新 ($timestamp)"
    $updateNote += "`n- 設定ファイルの変更を自動的に反映"
    
    # Add to change history section
    $newContent = @()
    $inChangeHistory = $false
    
    foreach ($line in $docContent) {
        $newContent += $line
        
        if ($line -match "## 変更履歴") {
            $inChangeHistory = $true
        }
        
        if ($inChangeHistory -and $line -match "### 最新の変更点") {
            $newContent += ""
            $newContent += $updateNote
            $newContent += ""
            $inChangeHistory = $false
        }
    }
    
    # Write updated content
    $newContent | Out-File $DocsPath -Encoding UTF8
    
    Write-Host "ドキュメント更新完了: $DocsPath" -ForegroundColor Green
}

# Function to commit and push changes
function Commit-And-Push-Changes {
    param(
        [string]$ChangedFile,
        [bool]$ShouldPush = $false
    )
    
    $fileName = Split-Path $ChangedFile -Leaf
    $commitMessage = "ドキュメント自動更新: $fileName の変更を反映"
    
    try {
        # Add and commit
        git add $DocsPath
        git commit -m $commitMessage
        Write-Host "変更をコミットしました: $commitMessage" -ForegroundColor Green
        
        # Push if requested
        if ($ShouldPush) {
            Write-Host "GitHubにプッシュ中..." -ForegroundColor Yellow
            git push origin main
            Write-Host "プッシュが完了しました。" -ForegroundColor Green
        }
        else {
            Write-Host "プッシュするには -AutoPush オプションを使用してください。" -ForegroundColor Cyan
        }
    }
    catch {
        Write-Warning "Git操作に失敗しました: $($_.Exception.Message)"
    }
}

# Main execution
try {
    # Check if config files exist
    if (-not (Test-Path $KeymapPath)) {
        Write-Error "キーマップファイルが見つかりません: $KeymapPath"
        exit 1
    }
    
    # Extract information
    $layerInfo = Get-LayerInfo $KeymapPath
    $hardwareInfo = Get-HardwareInfo $JsonPath
    
    # Update documentation
    Update-Documentation $layerInfo $hardwareInfo
    
    # Commit and push if requested
    if ($ConfigFile) {
        Commit-And-Push-Changes $ConfigFile $AutoPush
    }
    
    Write-Host "ドキュメント更新処理が完了しました。" -ForegroundColor Green
    
}
catch {
    Write-Error "エラーが発生しました: $($_.Exception.Message)"
    exit 1
} 
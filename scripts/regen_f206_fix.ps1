$root = 'c:\Users\PavanPinisetti\CICD_DEMO\JIRAS\CICD_APEX_COPILOT\src\database\wksp_ebs2cloud_migration\apex_apps'
$f205 = Join-Path $root 'f205\f205.sql'
$f206 = Join-Path $root 'f206\f206.sql'
$backupCorrupt = Join-Path $root 'f206\f206.sql.corrupt.bak'
$backupOld = Join-Path $root 'f206\f206.sql.bak2'

if (-not (Test-Path $f205)) { Write-Error "f205 not found: $f205" ; exit 2 }

# Backup current f206 if present
if (Test-Path $f206) {
    Copy-Item -Path $f206 -Destination $backupCorrupt -Force
    Write-Host "Backed up current (possibly corrupted) f206 to $backupCorrupt"
}

# Also backup earlier bak if exists
if (Test-Path (Join-Path $root 'f206\f206.sql.bak')) {
    Copy-Item -Path (Join-Path $root 'f206\f206.sql.bak') -Destination $backupOld -Force
    Write-Host "Backed up original bak to $backupOld"
}

# Read f205 as raw text
$text = Get-Content -Path $f205 -Raw -Encoding UTF8

# Update application id and prompt application name
$text = $text -replace 'APPLICATION 205', 'APPLICATION 206'
$text = $text -replace 'prompt APPLICATION 205 - APEX_CODE_REVIEW', 'prompt APPLICATION 206 - APEX_CODE_REVIEW_CORRECTED'

# Increment only wwv_flow_imp.id(<digits>) using 64-bit ints
$pattern = 'wwv_flow_imp\.id\((\d+)\)'
$re = [regex]::new($pattern)
$new = $re.Replace($text, [System.Text.RegularExpressions.MatchEvaluator]{ param($m) 
    $num = [int64]$m.Groups[1].Value
    $inc = $num + 1
    return "wwv_flow_imp.id($inc)"
})

# Write regenerated file
$dir = Split-Path $f206 -Parent
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
Set-Content -Path $f206 -Value $new -Encoding UTF8
Write-Host "Regenerated f206 from f205 and wrote to $f206"
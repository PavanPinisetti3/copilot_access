$root = 'c:\Users\PavanPinisetti\CICD_DEMO\JIRAS\CICD_APEX_COPILOT\src\database\wksp_ebs2cloud_migration\apex_apps'
$f205 = Join-Path $root 'f205\f205.sql'
$f206 = Join-Path $root 'f206\f206.sql'
$backup = Join-Path $root 'f206\f206.sql.bak'

if (-not (Test-Path $f205)) { Write-Error "f205 not found: $f205" ; exit 2 }

# Read original file as raw text (preserve newlines)
$text = Get-Content -Path $f205 -Raw -Encoding UTF8

# Backup existing f206 if present
if (Test-Path $f206) {
    Copy-Item -Path $f206 -Destination $backup -Force
    Write-Host "Backed up existing f206 to $backup"
}

# Update application id and application name prompt text
$text = $text -replace 'APPLICATION 205', 'APPLICATION 206'
$text = $text -replace 'prompt --application/set_environment\s*begin\s*wwv_flow_imp.import_begin \([\s\S]*?p_default_application_id=>205','prompt --application/set_environment\nbegin\nwwv_flow_imp.import_begin (', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
# (above safe no-op to keep structure; primary id increment below handles numeric ids)

# Define regex to increment only wwv_flow_imp.id(<digits>) occurrences
$pattern = 'wwv_flow_imp\.id\((\d+)\)'
$re = [regex]::new($pattern)

$new = $re.Replace($text, { param($m) 
    $num = [int]$m.Groups[1].Value
    return "wwv_flow_imp.id($($num + 1))"
})

# Write output
$dir = Split-Path $f206 -Parent
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

Set-Content -Path $f206 -Value $new -Encoding UTF8
Write-Host "Wrote regenerated f206 to $f206"

import re
from pathlib import Path

root = Path(r"c:\Users\PavanPinisetti\CICD_DEMO\JIRAS\CICD_APEX_COPILOT\src\database\wksp_ebs2cloud_migration\apex_apps")
f205 = root / 'f205' / 'f205.sql'
f206 = root / 'f206' / 'f206.sql'
backup = root / 'f206' / 'f206.sql.bak'

print('Reading', f205)
text = f205.read_text(encoding='utf-8')

# Backup existing f206 if present
if f206.exists():
    print('Backing up existing f206 to', backup)
    backup.write_text(f206.read_text(encoding='utf-8'), encoding='utf-8')

# Update application id and name
text = text.replace('APPLICATION 205', 'APPLICATION 206')
# Update application name (best-effort)
text = text.replace('APEX_CODE_REVIEW', 'APEX_CODE_REVIEW_CORRECTED')

# Increment all occurrences of wwv_flow_imp.id(<number>) by 1
pattern = re.compile(r"wwv_flow_imp\.id\((\d+)\)")

def inc(match):
    n = int(match.group(1))
    return f"wwv_flow_imp.id({n+1})"

new_text = pattern.sub(inc, text)

# Write out
f206.parent.mkdir(parents=True, exist_ok=True)
print('Writing regenerated f206 to', f206)
f206.write_text(new_text, encoding='utf-8')
print('Done')

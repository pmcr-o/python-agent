[CmdletBinding()]
param([switch]$Execute)
Set-StrictMode -Version Latest;$ErrorActionPreference='Stop'
if(-not $Execute){Write-Output 'dry run: python --version + python -m pip --version';return}
$py=Get-Command python -ErrorAction SilentlyContinue;if(-not $py){$py=Get-Command python3 -ErrorAction SilentlyContinue};if(-not $py){throw 'python runtime is not installed'}
$ver=@(& $py.Source --version 2>&1|ForEach-Object{[string]$_});if($LASTEXITCODE -ne 0){throw "python runtime inspection failed: $LASTEXITCODE"}
$pip=@(& $py.Source -m pip --version 2>&1|ForEach-Object{[string]$_});$pipOk=($LASTEXITCODE -eq 0)
[ordered]@{version=($ver -join ' ').Trim();executable=$py.Source;platform=[System.Runtime.InteropServices.RuntimeInformation]::OSDescription;pip=$pipOk;pipVersion=if($pipOk){($pip -join ' ').Trim()}else{''}}|ConvertTo-Json -Compress
return

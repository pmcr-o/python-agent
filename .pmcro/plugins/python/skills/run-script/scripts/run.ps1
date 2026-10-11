[CmdletBinding()]
param([string]$Workspace='.',[Parameter(Mandatory=$true)][string]$Script,[string[]]$Arguments=@(),[switch]$Apply)
Set-StrictMode -Version Latest;$ErrorActionPreference='Stop'
$root=(Resolve-Path -LiteralPath $Workspace).Path
if([IO.Path]::IsPathRooted($Script)-or $Script -match '(^|[\\/])\.\.([\\/]|$)'){throw 'Script must be workspace-relative'}
$full=[IO.Path]::GetFullPath((Join-Path $root $Script));$prefix=[IO.Path]::GetFullPath($root);if(-not $prefix.EndsWith([IO.Path]::DirectorySeparatorChar)){$prefix+=[IO.Path]::DirectorySeparatorChar};if(-not $full.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){throw 'Script escapes workspace'}
if([IO.Path]::GetExtension($full) -ne '.py'){throw 'Script must have .py extension'};if(-not(Test-Path -LiteralPath $full -PathType Leaf)){throw 'Script not found'}
$display='python "'+$Script+'" '+(($Arguments|ForEach-Object{'"'+($_.Replace('"','\"'))+'"'}) -join ' ')
if(-not $Apply){Write-Output ('dry run: '+$display.Trim());return}
$py=Get-Command python -ErrorAction SilentlyContinue;if(-not $py){$py=Get-Command python3 -ErrorAction SilentlyContinue};if(-not $py){throw 'python runtime is not installed'}
Push-Location $root;try{& $py.Source $full @Arguments;$code=$LASTEXITCODE;if($code -ne 0){throw "python script failed: $code"}}finally{Pop-Location}
return

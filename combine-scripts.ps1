$scripts = 'script1.ps1', 'script2.ps1', 'script3.ps1'
(Get-Item $scripts | ForEach-Object { 
  "& {{`n{0}`n}}" -f (Get-Content -Raw $_.FullName) 
}) -join "`n`n" > 'combined.ps1'

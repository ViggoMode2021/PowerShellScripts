# Windows General #

# Windows General #1 (hostname)

hostname

# Windows General #2 (boot time)

systeminfo | find 'Boot Time'

# Windows General #3 (env)

dir env:

# Windows General #4 (cpu)

Get-Process | Where-Object { $_.CPU -gt 20 }

#Windows General #5 (disk space)

Get-PSDrive C

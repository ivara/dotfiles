# Prompt
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression
# stop using oh-my-posh and use starship instead
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/emodipt-extend.omp.json" | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -EditMode vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History

# Fzf
$startTime = Get-Date
Import-Module PSFzf
Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
$endTime = Get-Date
$elapsedTime = $endTime - $startTime
Write-Host "Import-Module PSFzf took $($elapsedTime.TotalSeconds) seconds"

# Icons
$startTime = Get-Date
Import-Module -Name Terminal-Icons
$endTime = Get-Date
$elapsedTime = $endTime - $startTime
Write-Host "Import-Module -Name Terminal-Icons took $($elapsedTime.TotalSeconds) seconds"


# Alias
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

$startTime = Get-Date
Invoke-Expression (& { (zoxide init powershell | Out-String) })
$endTime = Get-Date
$elapsedTime = $endTime - $startTime
Write-Host "Initializing Zoxide took $($elapsedTime.TotalSeconds) seconds"

$startTime = Get-Date
fnm env --use-on-cd | Out-String | Invoke-Expression
$endTime = Get-Date
$elapsedTime = $endTime - $startTime
Write-Host "fnm env (fast node manager) took $($elapsedTime.TotalSeconds) seconds"

$startTime = Get-Date
Invoke-Expression (&starship init powershell)
$endTime = Get-Date
$elapsedTime = $endTime - $startTime
Write-Host "Starship took $($elapsedTime.TotalSeconds) seconds"

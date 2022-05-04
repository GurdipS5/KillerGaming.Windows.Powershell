Set-PSRepository -Name "myInternalSource" -SourceLocation 'https://someNuGetUrl.com/api/v2' -PublishLocation 'https://someNuGetUrl.com/api/v2/packages'

Clear-RecycleBin -DriveLetter C -Force


$chocoPackages = $PSScriptRoot + "\chocoPackages.txt"

$DB = Get-Content $chocoPackages

foreach ($Data in $DB) {
choco install $DB -y
}

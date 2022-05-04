Set-PSRepository -Name "myInternalSource" -SourceLocation 'https://someNuGetUrl.com/api/v2' -PublishLocation 'https://someNuGetUrl.com/api/v2/packages'

Clear-RecycleBin -DriveLetter C -Force

choco install treesizefree -y
choco install iiscrypto
choco install datadog-agent
choco install sysinternals




}

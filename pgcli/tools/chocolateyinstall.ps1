$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://s3.amazonaws.com/pgcentral/bigsql-pgc-3.3.6.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  checksum      = 'AEC6A478E806EF6AE56CD52974E3C325067B2D547757D491A083169D0FDFE914'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$files = get-childitem $toolsDir -include *.exe -recurse
foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}
$pgcFile = ($($toolsDir) + "\bigsql\pgc.bat")

Install-BinFile -Name "pgc" -Path $pgcFile
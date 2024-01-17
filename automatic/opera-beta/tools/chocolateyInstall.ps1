﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-beta/107.0.5045.4/win/Opera_beta_107.0.5045.4_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-beta/107.0.5045.4/win/Opera_beta_107.0.5045.4_Setup_x64.exe'
  checksum       = 'f4bf3176afd55f61a87cf4c943d096da1f70f7a5aedc13989670c2e5c181a88c'
  checksum64     = 'd50e44aea69384999aaf59eaba34f41e2965a1ef4a2a1d7b027505974a7a2176'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '107.0.5045.4'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}

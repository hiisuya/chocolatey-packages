function GetDownloadInfo {
  param(
    [string]$downloadInfoFile,
    [string]$code,
    [string]$urlVersion
  )
  Write-Debug "Reading CSV file from $downloadInfoFile"
  $downloadInfo = Get-Content -Encoding UTF8 -Path $downloadInfoFile | ConvertFrom-Csv -Delimiter '|' -Header 'Code','URL64','Checksum64','URL32','Checksum32'
  $result = $downloadInfo | Where-Object { $_.Code -eq $code } | Select-Object -first 1
  if (!$result) {
    $result = $downloadInfo | Where-Object { $_.Code -eq 'en' } | Select-Object -first 1
    $result.URL64 = $result.URL64 -replace $urlVersion, "${urlVersion}${code}"
    $result.URL32 = $result.URL32 -replace $urlVersion, "${urlVersion}${code}"
    $result.Checksum32 = ''
    $result.Checksum64 = ''
  }
  $result
}

powershell -command "Get-ChildItem -Filter '*.ps1' -File -Recurse | ForEach-Object { Invoke-Item $_ }"
powershell -command "Get-ChildItem -Filter '*.bat' -File -Recurse | ForEach-Object { Invoke-Item $_ }"

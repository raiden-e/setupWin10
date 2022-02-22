powershell.exe -nologo -noprofile -command "Expand-Archive .\setup.zip -Destination $pwd"
setup.exe /configure office365config.xml >>office.log
$Url = $args[0]
$ZipFile = $env:TEMP + '\' + $(Split-Path -Path $Url -Leaf) 
$Destination= $args[1]
 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files) 
Start-Process $Destination

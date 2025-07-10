
$resultsPath = "D:\cdc-jmeter\results"

Get-ChildItem -Path $resultsPath -Recurse | Remove-Item -Force

$jtlName = "run_$(Get-Date -Format 'yyyyMMdd_HHmmss').jtl"

& "D:\apache-jmeter-5.6.3\bin\jmeter.bat" `
  -n `
  -t "D:\cdc-jmeter\tests\CDC Jmeter.jmx" `
  -q "D:\cdc-jmeter\configs\secret.properties" `
  -l "$resultsPath\$jtlName"

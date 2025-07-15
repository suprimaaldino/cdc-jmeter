# 🧠 Force JMeter to use Java 17 for this session
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"

# 🕒 Timestamped result folder
$timestamp    = Get-Date -Format "yyyyMMdd_HHmmss"
$resultsPath  = "D:\cdc-jmeter\results"
$runPath      = "$resultsPath\run_$timestamp"
$jtlName      = "$runPath\result.jtl"
$htmlReport   = "$runPath\html-report"

# 🧹 Clean old results (optional)
Remove-Item $resultsPath -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $runPath, $htmlReport | Out-Null

# ▶️ Run JMeter test
& "D:\apache-jmeter-5.6.3\bin\jmeter.bat" `
  -n `
  -t "D:\cdc-jmeter\tests\cdc-reqres.jmx" `
  -q "D:\cdc-jmeter\configs\secret.properties" `
  -l $jtlName

# 📊 Generate default HTML report
& "D:\apache-jmeter-5.6.3\bin\jmeter.bat" `
  -g $jtlName `
  -o $htmlReport

# 🌐 Open report in browser
Start-Process "$htmlReport\index.html"

# ✅ Status message
Write-Host "`n✅ Test executed at $timestamp"
Write-Host "Results saved to: $runPath"
Write-Host "Report location:  $htmlReport"
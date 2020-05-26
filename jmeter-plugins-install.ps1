$ErrorActionPreference = 'SilentlyContinue'
$JMeterVersion = $args
Write-Host "JMeter version is " $JMeterVersion

# Downloading CMD Runner
Invoke-WebRequest -URI http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/2.2/cmdrunner-2.2.jar `
-UseBasicParsing -Outfile C:\apache-jmeter-$JMeterVersion\apache-jmeter-$JMeterVersion\lib\cmdrunner-2.2.jar

Write-Output "Downloaded CMD Runner"

# Downloading JMeter Plugins Manager
Invoke-WebRequest -URI https://jmeter-plugins.org/get/ `
-UseBasicParsing -Outfile C:\apache-jmeter-$JMeterVersion\apache-jmeter-$JMeterVersion\lib\ext\jmeter-plugins-manager-1.4.jar

Write-Output "Downloaded Plugins Manager"

# Changing directory
Set-Location C:\apache-jmeter-$JMeterVersion\apache-jmeter-$JMeterVersion

# Generating bat file for JMeter plugins
java -cp .\lib\ext\jmeter-plugins-manager-1.4.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

Write-Output "Generated Plugins Manager bat file"

# Changing directory
Set-Location C:\apache-jmeter-$JMeterVersion\apache-jmeter-$JMeterVersion\

# Executing Plugin Manager
java -jar ".\lib\cmdrunner-2.2.jar" --tool org.jmeterplugins.repository.PluginManagerCMD status

# Installing Plugins
.\bin\PluginsManagerCMD.bat install-all-except jpgc-json,jpgc-oauth

Write-Output "Plugin installation complete."
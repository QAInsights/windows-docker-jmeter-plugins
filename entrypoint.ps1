# Prints the message with the passed arguments
Write-Host "Execution Started in CLI mode with the following arguments: $args"

# Constructs the JMeter command and execute it
$command = -join(".\jmeter ","$args")
Invoke-Expression $command

# Prints the execution completed message
Write-Host "Execution has been completed. Please check your host machine for the results."
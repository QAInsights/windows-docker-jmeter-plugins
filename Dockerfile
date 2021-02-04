# Dockerfile for Apache JMeter for Windows
# Indicates that the windowsservercore along with OpenJDK will be used as the base image.
FROM openjdk:8-windowsservercore

ARG JMETER_VERSION="5.4.1"
ENV JMETER_HOME /apache-jmeter-$JMETER_VERSION/apache-jmeter-$JMETER_VERSION/

# Metadata indicating an image maintainer.
LABEL maintainer="NaveenKumar Namachivayam" \
      website="www.qainsights.com"

# Downloads JMeterfrom one of the mirrors, if you prefer to change, you can change the URL
RUN Invoke-WebRequest -URI https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$env:JMETER_VERSION.zip \
-UseBasicParsing -Outfile /apache-jmeter-$env:JMETER_VERSION.zip

# Extract the downloaded zip file
RUN Expand-Archive /apache-jmeter-$env:JMETER_VERSION.zip -DestinationPath /apache-jmeter-$env:JMETER_VERSION

# Copies the entrypoint.ps1
COPY /entrypoint.ps1 /entrypoint.ps1
COPY /jmeter-plugins-install.ps1 /jmeter-plugins-install.ps1

RUN ["powershell.exe","/jmeter-plugins-install.ps1","$env:JMETER_VERSION"]
# Sets the Working directory
WORKDIR ${JMETER_HOME}/bin

# Sets a command or process that will run each time a container is run from the new image. For detailed instruction, go to entrypoint.ps1 file.
ENTRYPOINT ["powershell.exe", "/entrypoint.ps1"]

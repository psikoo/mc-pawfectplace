#!/bin/bash

cd papermc

# Env
PROJECT="paper"
#LATEST_VERSION=$(wget -qO -s https://api.papermc.io/v2/projects/${PROJECT} | jq -r '.versions[-1]')
MC_VERSION="1.21.4"
LATEST_BUILD=$(wget -qO -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds | jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

# Download jar
if [ "$LATEST_BUILD" != "null" ]; then
  JAR_NAME=${PROJECT}-${MC_VERSION}-${LATEST_BUILD}.jar
  PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"
  wget -q $PAPERMC_URL > paper.jar
  echo "> Jar download completed"
else
  echo "No stable build for version $MC_VERSION found :("
fi

# Set eula
echo "eula=true" > eula.txt

# run server
JAVA_OPTS="-Xms8192M -Xmx8192M"
#exec java -server $JAVA_OPTS -jar "paper.jar" nogui
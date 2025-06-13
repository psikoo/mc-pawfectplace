#!/bin/bash

cd papermc

PROJECT="paper"
MC_VERSION="1.21.4"

#LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/${PROJECT} | jq -r '.versions[-1]')
LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds | jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')
if [ "$LATEST_BUILD" != "null" ]; then
  JAR_NAME=${PROJECT}-${MC_VERSION}-${LATEST_BUILD}.jar
  PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"

  # Download the latest Paper version
  curl -o paper.jar $PAPERMC_URL
  echo "Download completed"
else
  echo "No stable build for version $MC_VERSION found :("
fi

java -Xms8192M -Xmx8192M -jar paper.jar nogui
echo "eula=${EULA:-false}" > eula.txt

JAVA_OPTS="-Xms8192M -Xmx8192M"
exec java -server $JAVA_OPTS -jar "paper.jar" nogui
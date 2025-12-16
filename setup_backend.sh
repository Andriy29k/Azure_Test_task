#!/bin/bash

set -euo pipefail

ENV_FILE="/home/${USER}/.backend_env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "${ENV_FILE} not found"
  exit 1
fi

set -a
source "${ENV_FILE}"
set +a

env | grep DATASOURCE_

sudo apt update
sudo apt install -y openjdk-8-jdk

wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz
sudo tar xzf apache-maven-3.9.11-bin.tar.gz -C /opt

sudo ln -sfn /opt/apache-maven-3.9.11 /opt/maven

export MAVEN_HOME=/opt/maven
export PATH="${MAVEN_HOME}/bin:${PATH}"

if [[ -d "/home/$USER/eSchool" ]]; then
  rm -rf "/home/${USER}/eSchool"
fi

git clone https://github.com/yurkovskiy/eSchool.git

cd eSchool

mvn clean package -DskipTests

if [[ ! -f "/home/${USER}/eSchool/target/eschool.jar" ]]; then
  echo "JAR not found after build"
  exit 1
fi

sudo tee "/etc/systemd/system/backend.service" > /dev/null <<EOF
[Unit]
Description=eSchool Backend
After=network.target

[Service]
User=${USER}
WorkingDirectory=/home/${USER}/eSchool
EnvironmentFile=${ENV_FILE}
ExecStart=/usr/bin/java -jar /home/${USER}/eSchool/target/eschool.jar
Restart=always
RestartSec=10
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable backend.service
sudo systemctl restart backend.service

sudo systemctl status backend.service --no-pager

#!/bin/bash

if [ ! -d TESTE ]; then
    mkdir TESTE
else
        rm -rf TESTE
        mkdir TESTE
fi

if [ ! -d UAT ]; then
    mkdir UAT
else
        rm -rf UAT
        mkdir UAT
fi

if [ ! -d PRODUCTION ]; then
    mkdir PRODUCTION
else
        rm -rf UAT
        mkdir UAT
fi

if [ ! -d DEV ]; then
    git clone https://github.com/jfsc/spring-petclinic.git DEV
else
        rm -rf DEV
        
        git clone https://github.com/jfsc/spring-petclinic.git DEV
        
fi

sudo apt-get update

sudo apt-get install default-jdk

export JAVA_HOME='/usr/lib/jvm/default-java'

sudo apt-get install maven

sudo apt-get install junit

echo '[INFO]: Install mysql and create user root and password root'

sudo apt-get install mysql-server

mysql -u root -proot -e "CREATE DATABASE sonardb;"

mysql -u root -proot -e "CREATE USER 'sonar'@'localhost' IDENTIFIED BY 'sonarpassword';"

mysql -u root -proot -e "GRANT ALL PRIVILEGES ON sonardb.* TO 'sonar'@'localhost';"

sudo rm -rf /opt/sonarqube-5.6

sudo rm -rf /opt/sonar-scanner-2.6.1

sudo rm -rf /opt/sonarqube-5.6.zip

sudo rm -rf /opt/sonar-scanner-2.6.1.zip

sudo wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.zip -P /opt

sudo wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.1.zip -P /opt

sudo unzip /opt/sonarqube-5.6.zip -d /opt

sudo unzip /opt/sonar-scanner-2.6.1.zip -d /opt

sudo chmod -R 777 /opt/sonarqube-5.6/conf/sonar.properties

sudo chmod -R 777 /opt/sonar-scanner-2.6.1/conf/sonar-scanner.properties

sudo echo "sonar.jdbc.username=sonardb" >> /opt/sonarqube-5.6/conf/sonar.properties

sudo echo "sonar.jdbc.password=sonarpassword" >> /opt/sonarqube-5.6/conf/sonar.properties

sudo echo "sonar.host.url=http://localhost:9000" >> /opt/sonar-scanner-2.6.1/conf/sonar-scanner.properties

SO_VERSION=`getconf LONG_BIT`

sudo /opt/sonarqube-5.6/bin/linux-x86-${SO_VERSION}/sonar.sh start

sudo cp settings.xml /etc/maven/

cd DEV

mvn clean install

mvn sonar:sonar

sudo apt-get remove docker docker-engine

sudo apt-get update

sudo apt-get -y install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

sudo apt-get install curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get -y install docker-ce

sudo docker build -t if1006petclinics .

sudo docker tag if1006petclinics jbsn/if1006petclinics

sudo docker push jbsn/if1006petclinics
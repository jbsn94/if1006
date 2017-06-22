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
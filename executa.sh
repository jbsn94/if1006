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

apt-get update

apt-get install default-jdk

export JAVA_HOME='/usr/lib/jvm/default-java'

apt-get install maven

apt-get install junit

mysql -u root -proot -e "CREATE DATABASE sonardb;"

mysql -u root -proot -e "CREATE USER 'sonar'@'localhost' IDENTIFIED BY 'sonarpassword';"

mysql -u root -proot -e "GRANT ALL PRIVILEGES ON sonardb.* TO 'sonar'@'localhost';"

wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.zip -P /opt

wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.1.zip -P /opt

unzip /opt/sonarqube-5.6.zip -d /opt

unzip /opt/sonar-scanner-2.6.1.zip -d /opt

chmod -R 777 /opt/sonarqube-5.6/conf/sonar.properties

chmod -R 777 /opt/sonar-scanner-2.6.1/conf/sonar-scanner.properties

echo "sonar.jdbc.username=sonardb" >> /opt/sonarqube-5.6/conf/sonar.properties

echo "sonar.jdbc.password=sonarpassword" >> /opt/sonarqube-5.6/conf/sonar.properties

echo "sonar.host.url=http://localhost:9000" >> /opt/sonar-scanner-2.6.1/conf/sonar-scanner.properties

SO_VERSION=`getconf LONG_BIT`

/opt/sonarqube-5.6/bin/linux-x86-${SO_VERSION}/sonar.sh start

cp settings.xml /etc/maven/

cd DEV

mvn clean install

mvn sonar:sonar
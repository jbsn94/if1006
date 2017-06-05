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

sudo apt-get install default-jdk

export JAVA_HOME='/usr/lib/jvm/default-java'

sudo apt-get install maven

sudo apt-get install junit

cd DEV

mvn clean install

echo "Implementação concluida."
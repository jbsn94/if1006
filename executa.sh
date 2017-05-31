#!/bin/bash

if [ ! -d TESTE ]; then
    mkdir TESTE
    echo "O diretório TESTE foi criado com sucesso."
else
    read -p "O diretório TESTE já existe, deseja deletar e criar novamente?(S/N) [S] " -n 1 -r

    echo
    if [[ ($REPLY =~ ^[Ss]$) || ($REPLY == "") ]]; then
        rm -rf TESTE
        mkdir TESTE
        echo "Diretório TESTE criado com sucesso."
    fi
fi

if [ ! -d UAT ]; then
    mkdir UAT
    echo "O diretório UAT foi criado com sucesso."
else
    read -p "O diretório UAT já existe, deseja deletar e criar novamente?(S/N) [S] " -n 1 -r
    
    echo
    
    if [[ ($REPLY =~ ^[Ss]$) || ($REPLY == "") ]]; then
        rm -rf UAT
        mkdir UAT
        
        echo "Diretório UAT criado com sucesso."
    fi
fi

if [ ! -d PRODUCTION ]; then
    mkdir PRODUCTION
    echo "The directory PRODUCTION was created."
else
    read -p "O diretório PRODUCTION já existe, deseja deletar e criar novamente?(S/N) [S] " -n 1 -r

    echo
    if [[ ($REPLY =~ ^[Ss]$) || ($REPLY == "") ]]; then
        rm -rf UAT
        mkdir UAT
        echo "Diretório PRODUCTION criado com sucesso."
    fi
fi

if [ ! -d DEV ]; then
    git clone https://github.com/jfsc/spring-petclinic.git DEV
else
    read -p "O diretório DEV já existe, deseja deletar e criar novamente?(S/N) [S] " -n 1 -r

    echo
    if [[ ($REPLY =~ ^[Ss]$) || ($REPLY == "") ]]; then
        rm -rf DEV
        
        git clone https://github.com/jfsc/spring-petclinic.git DEV
        
        echo "Diretório DEV criado com sucesso."
    fi
fi

echo "Implementação concluida."
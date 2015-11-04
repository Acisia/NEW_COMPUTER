#!/bin/bash
###################################################################################################################
# Author : Louis DAUBIGNARD
# Date   : 11/12/2014
#
# Description : Script pour :
#		- cree le user et l'environnement d un user linux
#
# Syntax : crea_user.sh 
#
###################################################################################################################
#CHEMIN RACINE
PATHROOT="$PWD"
NOMPROJECTSCRIPT="INSTALL DOKUWIKI"
# cf fcihier user_param
#PROJECTNAME=""
#PATHWWW="www"

#RECUPERATION DES FONCTIONS
. $PATHROOT/../lib/functions.sh

#RECUPERATION DES PARAMETRES
checkPathFile "$PATHROOT/user_param.sh" "Fichier de param"
if [ $? -eq 0 ];then
	echo -e "\033[31m[ERREUR]\033[0m Manque fichier de param"
	exit 1
fi
. $PATHROOT/user_param.sh
clear
printMessageTo  "             $NOMPROJECTSCRIPT			" "1" 

printMessageTo  "             DOWNLOAD dokuwiki			" "2" 
curl -O http://download.dokuwiki.org/out/$DOKUWIKIVER
printMessageTo  "             DECOMPRESSION Archive			" "2" 
tar -xzvf $DOKUWIKIVER


printMessageTo  "             PLUGINS	note		" "2" 
cd "$PATHROOT/dokuwiki/lib/plugins"
# https://www.dokuwiki.org/plugin:note
# https://www.dokuwiki.org/plugin:color
# https://www.dokuwiki.org/plugin:dw2pdf
cp -R $PATHROOT/plugins/* $PATHROOT/dokuwiki/lib/plugins

cd $PATHROOT
printMessageTo  "             RENOMMER			" "2" 
mv -f "dokuwiki" "$PROJECTNAME"

printMessageTo  "             DEPLACER			" "2" 
checkPathDst "$PROJECTNAME" "Chemin DOKUWIKI $PROJECTNAME"
checkPathDst "$PATHWWW$PROJECTNAME" "Chemin web $PATHWWW$PROJECTNAME"
cp -R dokuwiki/* $PROJECTNAME
cp -R dokuwiki/* $PATHWWW$PROJECTNAME

printMessageTo  "             NETTOYAGE			" "2" 
rm -r dokuwiki
printMessageTo  "             TEST PAGE INSTALL			" "2" 
start iexplore.exe "http://localhost/toyota/install.php?l=fr&d[title]=$PROJECTNAME&d[superuser]=$USER_LOGIN&d[fullname]=$USER_PRENOM $USER_NOM&d[email]=$USER_ADRESSEMAIL&d[password]$USER_PASSWORD&d[confirm]=$USER_PASSWORD&d[policy]=2&d[pop]=0"
echo "    FIN" 

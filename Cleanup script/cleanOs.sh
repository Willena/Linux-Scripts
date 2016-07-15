#!/bin/sh

listPackage()
{
  echo "-- Package List --"
  dpkg-query -W --showformat='${Installed-Size} ${Package}\n' | sort -n
}

deleteOrphelin()
{
  echo "-- Delete Orphelin --"
  dpkg -P $(dpkg -l | awk '$1~/^rc$/{print $2}')
}

deleteDep()
{
  echo "-- Delete Dep --"
  aptitude purge ~c
}

emptyCache()
{
  echo "-- Empty Cache --"
  aptitude autoclean
}

listDir()
{
  echo "-- List Dir --"
  cd /
  du -S | sort -n
}

execAll()
{
  echo "___All___"
  deleteOrphelin
  deleteDep
  emptyCache
  echo "___Done All___"
}



echo "Utilitaire de netoyage de Debian"
echo "Par Guillaume Villena"
echo "15/07/2016"

echo 
echo 
echo "Menu :"
echo "     1) Lister les package trie par taille"
echo "     2) Suprimer les fichier de configuration orphelin"
echo "     3) Supprimer les dependences inutile"
echo "     4) Vider le cache apt"
echo "     5) Lister les dossiers"
echo "     6) Executer toute les suppression"
echo 
echo 


while true
do
  echo -n "Votre choix :"
  read c


  case $c in
    1) listPackage ;;
    2) deleteOrphelin ;;
    3) deleteDep ;;
    4) emptyCache ;;
    5) listDir ;;
    6) execAll ;;
  esac
done

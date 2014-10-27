#!/bin/bash
#basedir="/bes3fs/offline/data/664p01/rscan/dst"
basedir="/bes3fs/offline/data/664p01/rscan/dst"
filelist=""
enter=$'\n'
for datedir in `ls $basedir`;do
  for file in `ls ${basedir}\${datedir}`;do
    if [ $filelist == "" ];then
      filelist=\"$basedir/$datedir/$file\"
    else
      filelist="$filelist,\"${enter} $basedir/$datedir/$file\""
    fi
  done
  echo $datedir
done

cat>list.txt<<EOF
$filelist
EOF

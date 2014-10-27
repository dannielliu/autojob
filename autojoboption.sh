#!/bin/bash
basedir="/bes3fs/offline/data/664p01/xyz/4260/dst"
#basedir="/Users/danny/software/beswork" # for test, will use the upper one
filelist=""
algindex="gepep_"
usealg="fastpipill"
runNo=""
scriptname="data_xyz_${usealg}_e4260"
enter=$'\n'
let i=0

#for datedir in `ls $basedir`;do
#datadir=121215
#  if [ -d $datedir ];then
#    for file in `ls ${basedir}/${datedir}`;do
#      if [[ $filelist == "" ]];then
#        filelist=$basedir/$datedir/$file
#      else
#        filelist="$filelist,${enter}$basedir/$datedir/$file"
#      fi
#    done
#    echo $datedir
#  fi
#done
let suffix=1
CreateScript(){
cat>${scriptname}_${suffix}.txt<<EOF
#include "\$ROOTIOROOT/share/jobOptions_ReadRec.txt"
#include "\$VERTEXFITROOT/share/jobOptions_VertexDbSvc.txt"
#include "\$MAGNETICFIELDROOT/share/MagneticField.txt"
#include "\$ABSCORROOT/share/jobOptions_AbsCor.txt"
#include "\$GGJPSIALGROOT/share/jobOptions_Ggjpsi.txt"

Ggjpsi.${algindex}${usealg} = true;

// Input REC or DST file name 
EventCnvSvc.digiRootInputFile = {
$filelist
};

// Set output level threshold (2=DEBUG, 3=INFO, 4=WARNING, 5=ERROR, 6=FATAL )
MessageSvc.OutputLevel = 6;

// Number of events to be processed (default is 10)
ApplicationMgr.EvtMax = 50000000;

ApplicationMgr.HistogramPersistency = "ROOT";
NTupleSvc.Output = { "GETAPETAP DATAFILE='/scratchfs/bes/liud/xyz/${usealg}/data_xyz_${usealg}_e4260_$suffix.root' OPT='NEW' TYP='ROOT'"};

EOF
let suffix+=1
}

# main

let i=0
#datedir=121215
echo $datedir
for datedir in `ls $basedir`;do
#ls ${basedir}/${datedir}
#  if [ -d $datedir ];then
    #ls ${basedir}/${datedir}/run_0029677_All_file001_SFO-1.dst
    for file in `ls ${basedir}/${datedir}`;do
      let i+=1
      if [[ $filelist == "" ]];then
        filelist="\"$basedir/$datedir/$file\""
      else
        filelist="$filelist,${enter}\"$basedir/$datedir/$file\""
      fi
      if [[ $i == 100 ]];then
        CreateScript
        let i=0
        filelist=""
      fi
    done
    if [[ $filelist != "" ]];then
      CreateScript
    fi
    echo $datedir
#  fi
done


#CreateScript

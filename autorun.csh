#!/bin/tcsh
source /afs/ihep.ac.cn/users/l/liud/.tcshrc
set curdir="/besfs/users/liud/workarea/GgjpsiAlg/GgjpsiAlg-00-00-01/run/data/fastpipill"
cd $curdir
echo $curdir
@ i=1
foreach txtjob ( data_xyz_*.txt )
  echo $txtjob
  boss.exe $curdir/$txtjob >log$i &
  @ i++
end
#boss -q data_Rvalue_pipill_1.txt


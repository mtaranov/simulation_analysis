#!/bin/bash

m="5"

while [ $m -le 13 ]
do
charmm < hbond.inp m=$m > hbond_${m}ns.out
cat hbond_${m}ns.dat >> hbond.dat
m=$[$m+1]
done

m="20"

while [ $m -le 70 ]
do
charmm < hbond.inp m=$m > hbond_${m}ns.out
cat hbond_${m}ns.dat >> hbond.dat
m=$[$m+10]
done

m="71"

while [ $m -le 73 ]
do
charmm < hbond.inp m=$m > hbond_${m}ns.out
cat hbond_${m}ns.dat >> hbond.dat
m=$[$m+1]
done

m="83"

while [ $m -le 103 ]
do
charmm < hbond.inp m=$m > hbond_${m}ns.out
cat hbond_${m}ns.dat >> hbond.dat
m=$[$m+10]
done

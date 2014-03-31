#!/bin/sh
#Calculating Equilibrium S2

# Assuming $1_bondvector_list_all is a list with format: resid ctype htype S2exp Segid
#Compiling S2 calculator program
#g++ S2_single.cpp -o S2_single

#Determining number of bond vectors from $1_bondvector_list_all file
Nvector=`wc -l $1_bondvector_list_all | awk '//{print $1;}'`


#Looping over lines in file
for (( i=1; i<=$Nvector; i=i+1 ))
do

for (( j=1; j<=10; j=j+1)); 
do
	RESID=`awk '{if( NR=="'"$i"'") print $1}' $1_bondvector_list_all`
	CTYPE=`awk '{if( NR=="'"$i"'") print $2}' $1_bondvector_list_all`
	HTYPE=`awk '{if( NR=="'"$i"'") print $3}' $1_bondvector_list_all`
	S2exp=`awk '{if( NR=="'"$i"'") print $4}' $1_bondvector_list_all`	
	RESNAME=`awk '{if( NR=="'"$i"'") print $5}' $1_bondvector_list_all`	
	SEGID=`awk '{if( NR=="'"$i"'") print $6}' $1_bondvector_list_all`
	$CHARMMEXEC PSF=$1 COR=$1 RUN=$j S=$1 RESID=${RESID} HTYPE=${HTYPE} CTYPE=${CTYPE} DCD=$1/$j SEGID=${SEGID} RESNAME=${RESNAME} < S2_vector.inp > log_$1_$i
#	S2calE=`./S2_single vector_components.dat 100`
	S2calC=`head -n 1000 corel_$1_${j}_${SEGID}_${RESID}_${CTYPE}${HTYPE}.dat | tail -n 300 | awk '{sum+=$2} END { print sum/NR}'`
	echo "${S2calC}" >>junk
	#for (( k=1; k<10; k++ ))
	#do
	a=`awk '{if( NR=="'"1"'") print $1}' junk`
	b=`awk '{if( NR=="'"2"'") print $1}' junk`
	c=`awk '{if( NR=="'"3"'") print $1}' junk`
	d=`awk '{if( NR=="'"4"'") print $1}' junk`
	e=`awk '{if( NR=="'"5"'") print $1}' junk`
	f=`awk '{if( NR=="'"6"'") print $1}' junk`
	g=`awk '{if( NR=="'"7"'") print $1}' junk`
	h=`awk '{if( NR=="'"8"'") print $1}' junk`
	l=`awk '{if( NR=="'"9"'") print $1}' junk`
	m=`awk '{if( NR=="'"10"'") print $1}' junk`
	AVE=`awk '{sum+=$1} END { print sum/NR}' junk`
done
echo "${SEGID}  	${RESID}   	${S2exp} 	${a}   	${b}   	${c}   	${d}   	${e}   	${f}   	${g}   	${h}   	${l}   	${m}   	${AVE}"
rm junk
done
#deleted WHICH=LOWER
#corel_@S_@run_@SEGID_@RESID_@CTYPE@HTYPE.dat
#	`	


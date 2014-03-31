#!/bin/sh
#Calculating Equilibrium S2

# Assuming $1_bondvector_list is a list with format: resid ctype htype S2exp Segid
#Compiling S2 calculator program
#g++ S2_single.cpp -o S2_single

#Determining number of bond vectors from $1_bondvector_list file
Nvector=`wc -l $1_bondvector_list | awk '//{print $1;}'`

#Looping over lines in file
for (( i=1; i<=$Nvector; i=i+1 ))
do
for (( j=1; j<=10; j=j+1 ))
do
	RESID=`awk '{if( NR=="'"$i"'") print $1}' $1_bondvector_list`
	CTYPE=`awk '{if( NR=="'"$i"'") print $2}' $1_bondvector_list`
	HTYPE=`awk '{if( NR=="'"$i"'") print $3}' $1_bondvector_list`
	S2exp=`awk '{if( NR=="'"$i"'") print $4}' $1_bondvector_list`	
	RESNAME=`awk '{if( NR=="'"$i"'") print $5}' $1_bondvector_list`	
	SEGID=`awk '{if( NR=="'"$i"'") print $6}' $1_bondvector_list`
	$CHARMMEXEC PSF=$1 COR=$1 RUN=${j} S=$1 RESID=${RESID} HTYPE=${HTYPE} CTYPE=${CTYPE} DCD=$1/${j} SEGID=${SEGID} RESNAME=${RESNAME} < S2_vector.inp > log
#	S2calE=`./S2_single vector_components.dat 100`
	S2calC=`tail -n 25 corel_$1_${j}_${SEGID}_${RESID}_${CTYPE}${HTYPE}.dat | awk '{sum+=$2} END { print sum/NR}'`	
	#Printing out results to standard output
	#echo "${RESID} ${S2calC} ${S2CalE} ${S2exp}"
	#echo "${S2calC}"
	#rm vector_components.dat
	CTYPE2=`awk '{if( NR=="'"$i"'") print $2}' $1_bondvector_list_e`
	HTYPE2=`awk '{if( NR=="'"$i"'") print $3}' $1_bondvector_list_e`
#	RESID2=`awk '{if( NR=="'"$i"'") print $7}' $1_bondvector_list`
	sh S2_vmd.sh $SEGID $RESID $CTYPE2 $HTYPE2 $1 $j > vmd_out
	grep "equilibrium S2:" vmd_out | cut -c 18-28 >junk1
	S2calE=`awk '{if( NR=="'"1"'") print $1}' junk1`
	#echo "${RESID} ${S2calE} ${S2exp}"
	rm junk1
	echo "${S2calE}" >>junk2
	a=`awk '{if( NR=="'"1"'") print $1}' junk2`
	b=`awk '{if( NR=="'"2"'") print $1}' junk2`
	c=`awk '{if( NR=="'"3"'") print $1}' junk2`
	d=`awk '{if( NR=="'"4"'") print $1}' junk2`
	e=`awk '{if( NR=="'"5"'") print $1}' junk2`
	f=`awk '{if( NR=="'"6"'") print $1}' junk2`
	g=`awk '{if( NR=="'"7"'") print $1}' junk2`
	h=`awk '{if( NR=="'"8"'") print $1}' junk2`
	l=`awk '{if( NR=="'"9"'") print $1}' junk2`
	m=`awk '{if( NR=="'"10"'") print $1}' junk2`
done
echo "${RESID} 	${S2exp}	$a	$b	$c	$d	$e	$f	$g	$h	$l	$m"
rm junk2
done


#deleted WHICH=LOWER

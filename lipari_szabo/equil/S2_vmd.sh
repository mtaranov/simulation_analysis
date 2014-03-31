#!/bin/sh
#calculates N1-H1 S2 order parameters for resid 1
export VMDEXE=/Applications/VMD1.9.app/Contents/vmd/vmd_MACOSXX86
cat << EOF >| vmd.s2.tcl
source align_ref.tcl
source s2_calc_gavin.tcl
mol new $5/$5.psf -type psf
mol addfile $5/$6.dcd waitfor all
align_ref "nucleic" 
S2_calculator "segid $1 and resid $2 and name $3 "  "segid $1 and resid $2 and name $4"
exit
EOF
$VMDEXE -dispdev text -e vmd.s2.tcl 

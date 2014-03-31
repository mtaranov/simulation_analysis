mol new /Volumes/DriveMaryna/RESEARCH/T7RNAP_elongation/EQUIL/NAMD_100_from_prop_k=6_on_rna/t7rnap_100bp.psf  -type psf
mol addfile /Volumes/DriveMaryna/RESEARCH/T7RNAP_elongation/EQUIL/NAMD_100_from_prop_k=6_on_rna/100_93ns.dcd   waitfor all
source rmsf.tcl
rmsf "rmsf_100bp.dat"
exit

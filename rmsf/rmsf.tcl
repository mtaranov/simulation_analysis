proc rmsf {out} { 
		# use frame 0 for the reference
		set reference [ atomselect top "protein and noh"  frame 0 ]		
		# the frame being compared
		set compare [ atomselect top "protein and noh" ]
		# selection of atom to be transformed
		set all [ atomselect top "all" ]
		#get number of frames
		set nframes [ molinfo top get numframes ]
		# Loop over frames of trajectory; first align then determine x,y,z for bond vector
		for { set i 1 } { $i <= $nframes } { incr i } {
				# Align protein acid relative to reference prior to calculating bond vector components
				# get the correct frame
				$compare frame $i
				$all frame $i
				# compute the transformation
				set trans_mat [measure fit $compare $reference]
				# do the alignment
				$all move $trans_mat			
	}
               set ca [atomselect top "protein and name CA"] 
               set rmsf [measure rmsf $ca] 
               set outfile [open "$out" w] 
               foreach x $rmsf { 
               puts $outfile $x 
               } 
               close $outfile 
}

proc S2_calculator { ctype_selection htype_selection  } { 		
		set nframes [ molinfo top get numframes ]
		# Loop over frames of trajectory; first align then determine x,y,z for bond vector
		#set f [ open $output_file "w" ]
		set x2 0
		set y2 0
		set z2 0
		set xy 0
		set xz 0
		set yz 0

		set sel1 [atomselect top $ctype_selection frame 0] 
		if {[$sel1 num] != 1} {
		error "label_atom: ’$ctype_selection’ must select 1 atom"
		}
		set sel2 [atomselect top $htype_selection  frame 0] 
		if {[$sel2 num] != 1} {
		error "label_atom: ’$htype_selection’ must select 1 atom"
		}    
		
		for { set i 0 } { $i < $nframes } { incr i } {
				#update selection and frame
				set sel1 [atomselect top $ctype_selection frame $i] 
				if {[$sel1 num] != 1} {
				error "label_atom: ’$ctype_selection’ must select 1 atom"
				}
				set sel2 [atomselect top $htype_selection  frame $i] 
				if {[$sel2 num] != 1} {
				error "label_atom: ’$htype_selection’ must select 1 atom"
				}    
				set com1 [measure center $sel1]
				set com2 [measure center $sel2]
				set vecCH [ vecsub $com1 $com2]
				set vecL [ veclength $vecCH ]
				set vecCH [ vecscale [ expr (1/$vecL) ] $vecCH ]
				
				#get vector components
				set xcomp [lindex $vecCH 0]
				set ycomp [lindex $vecCH 1]
				set zcomp [lindex $vecCH 2]
				
				set x2 [ expr  $x2 + $xcomp*$xcomp ] 
				set y2 [ expr  $y2 + $ycomp*$ycomp ] 
				set z2 [ expr  $z2 + $zcomp*$zcomp ] 
				
				set xy [ expr  $xy + $xcomp*$ycomp ] 
				set xz [ expr  $xz + $xcomp*$zcomp ] 
				set yz [ expr  $yz + $ycomp*$zcomp ] 
				
	}	
	set x2 [ expr $x2/$nframes]
	set y2 [ expr $y2/$nframes]
	set z2 [ expr $z2/$nframes]
	
	set xy [ expr $xy/$nframes]
	set xz [ expr $xz/$nframes]
	set yz [ expr $yz/$nframes]

	set s2 [ expr 1.5*( pow($x2,2) + pow($y2,2) + pow($z2,2) ) + 3*( pow($xy,2) + pow($xz,2) + pow($yz,2) ) - 0.5 ]
	puts " equilibrium S2: $s2 "
	#close $f 
}

# This file is part of Scid (Shane's Chess Information Database).
#
# Scid is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.
#
# Scid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Scid.  If not, see <http://www.gnu.org/licenses/>.

### move.tcl
### Functions for moving within a game.

namespace eval ::move {}

proc ::move::drawVarArrows {} {
  if {! $::showVarArrows || $::autoplayMode} { return 0 }
	if {[winfo exists .coachWin]} { return 0 }
	if {[winfo exists .serGameWin]} { return 0 }
	
	set bDrawArrow 0
  set varList [sc_var list UCI]

	if {$varList != ""} {		
		set move [sc_game info nextMoveUCI]
		if {$move != ""} { set varList [linsert $varList 0 $move] }		
		foreach { move } $varList {
			set bDrawn 0			
			set sq_start [ ::board::sq [ string range $move 0 1 ] ]
			set sq_end [ ::board::sq [ string range $move 2 3 ] ]
		    foreach mark $::board::_mark(.main.board) {
		    	if { [lindex $mark 0] == "arrow" } {
					if {[lindex $mark 1] == $sq_start && [lindex $mark 2] == $sq_end} { 
						set bDrawn 1
						break
					}
				}
			}
			if {! $bDrawn } { set bDrawArrow 1; break }
		}
  }
  
	return $bDrawArrow
}

proc ::move::showVarArrows {} {
   	set move [sc_game info nextMoveUCI]
  	if {$move != ""} {
  		set sq_start [ ::board::sq [ string range $move 0 1 ] ]
		set sq_end [ ::board::sq [ string range $move 2 3 ] ]
	    ::board::mark::add ".main.board" "arrow" $sq_start $sq_end "green"  		
	}
	set varList [sc_var list UCI]  
	foreach { move } $varList {
		set sq_start [ ::board::sq [ string range $move 0 1 ] ]
		set sq_end [ ::board::sq [ string range $move 2 3 ] ]
	    ::board::mark::add ".main.board" "arrow" $sq_start $sq_end "blue"
	}
}

proc ::move::Start {} {
  if {[winfo exists .coachWin]} {
    set ::tacgame::analysisCoach(paused) 1
    .coachWin.fbuttons.resume configure -state normal
  }
  
  sc_move start
  updateBoard
  if {[::move::drawVarArrows]} { ::move::showVarArrows }
}

proc ::move::End {} { 
  sc_move end
  updateBoard
  if {[::move::drawVarArrows]} { ::move::showVarArrows }
}

proc ::move::ExitVar {} {
  sc_var exit; 
  updateBoard -animate; 
  if {[::move::drawVarArrows]} { ::move::showVarArrows }
}

proc ::move::Back {{count 1}} {
  if {[sc_pos isAt start]} { return } 
  if {[sc_pos isAt vstart]} { ::move::ExitVar; return }
  
  ### todo: if playing, remove this move from hash array S.A ??
  
  if {[winfo exists .coachWin]} {
    set ::tacgame::analysisCoach(paused) 1
    .coachWin.fbuttons.resume configure -state normal
    # mess with game clocks ???
  }
  
  sc_move back $count
  
  if {$count == 1} {
    # Do animation and speech:
    updateBoard -animate
    ::utils::sound::AnnounceBack
  } else {
    updateBoard
  }

  if {[::move::drawVarArrows]} { ::move::showVarArrows }
}
################################################################################
# 
################################################################################
proc ::move::Forward {{count 1}} {
  global autoplayMode
  
  if {[sc_pos isAt end]  ||  [sc_pos isAt vend]} { return }
  
  set bArrows [::move::drawVarArrows]
  
  set move [sc_game info next]
  if {$count == 1} {
    if {[sc_var count] != 0 && ! $autoplayMode && $::showVarPopup} {
      ::commenteditor::storeComment
      showVars
      set bArrows $::showVarArrows 
    } else {    
      if {! $bArrows} { sc_move forward }
    }    
    
    # Animate and speak this move:
    updateBoard -animate
    ::utils::sound::AnnounceForward $move
  } else {
    if {! $bArrows} { sc_move forward $count }
    updateBoard
  }
  if {$bArrows} { ::move::showVarArrows }
}


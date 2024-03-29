###
###
### main.tcl: Routines for creating and updating the main window.
###

############################################################
# Keyboard move entry:
#   Handles letters, digits and BackSpace/Delete keys.
#   Note that king- and queen-side castling moves are denoted
#   "OK" and "OQ" respectively.
#   The letters n, r, q, k, o and l are promoted to uppercase
#   automatically. A "b" can match to a b-pawn or Bishop move,
#   so in some rare cases, a capital B may be needed for the
#   Bishop move to distinguish it from the pawn move.

set moveEntry(Text) ""
set moveEntry(List) {}

# Bind Alt+letter key to nothing, to stop Alt+letter from
# matching the move entry bindings, so Alt+letter ONLY invokes
# the menus:
foreach key {a b c d e f g h i j k l m n o p q r s t u v w x y z} {
    bind $dot_w <Alt-$key> {
        # nothing
    }
}

proc moveEntry_Clear {} {
    global moveEntry
    set moveEntry(Text) ""
    set moveEntry(List) {}
}

proc moveEntry_Complete {} {
    global moveEntry
    
    if { ! [::fics::playerCanMove] || ! [::reviewgame::playerCanMove] } { ;# not player's turn
        moveEntry_Clear
        return
    }
    
    set len [llength $moveEntry(List)]
    if {$len > 0} {
        if {$moveEntry(AutoExpand)} {
            # Play a bell sound to let the user know the move was accepted already,
            # but only if move announcement is off?
            # bell
        }
        set move [lindex $moveEntry(List) 0]
        if {$move == "OK"} { set move "O-O" }
        if {$move == "OQ"} { set move "O-O-O" }
        set action "replace"
        if {![sc_pos isAt vend]} { set action [confirmReplaceMove] }
        if {$action == "replace"} {
            undoFeature save
            sc_move addSan $move
        } elseif {$action == "var"} {
            undoFeature save
            sc_var create
            sc_move addSan $move
        } elseif {$action == "mainline"} {
            undoFeature save
            sc_var create
            sc_move addSan $move
            sc_var exit
            sc_var promote [expr {[sc_var count] - 1}]
            sc_move forward 1
        }
        
        # Now send the move done to FICS and NOVAG Citrine
        set promoletter ""
        set moveuci [sc_game info previousMoveUCI]
        if { [ string length $moveuci ] == 5 } {
            set promoletter [ string tolower [ string index $moveuci end ] ]
        }
        if { [winfo exists .fics] } {
            if { [::fics::playerCanMove] } {
                if { $promoletter != "" } {
                    ::fics::writechan "promote $promoLetter"
                }
                ::fics::writechan [ string range $moveuci 0 3 ]
            }
        }
        
        if {$::novag::connected} {
            ::novag::addMove "[ string range $moveuci 0 3 ]$promoLetter"
        }
        
        moveEntry_Clear
        updateBoard -pgn -animate
        ::utils::sound::AnnounceNewMove $move
        if {$action == "replace"} { ::tree::doTraining }
    }
}

proc moveEntry_Backspace {} {
    global moveEntry
    set moveEntry(Text) [string range $moveEntry(Text) 0 \
            [expr {[string length $moveEntry(Text)] - 2}]]
    set moveEntry(List) [sc_pos matchMoves $moveEntry(Text) $moveEntry(Coord)]
    updateStatusBar
}

proc moveEntry_Char {ch} {
    global moveEntry
    set oldMoveText $moveEntry(Text)
    set oldMoveList $moveEntry(List)
    append moveEntry(Text) $ch
    set moveEntry(List) [sc_pos matchMoves $moveEntry(Text) $moveEntry(Coord)]
    set len [llength $moveEntry(List)]
    if {$len == 0} {
        # No matching moves, so do not accept this character as input:
        set moveEntry(Text) $oldMoveText
        set moveEntry(List) $oldMoveList
    } elseif {$len == 1} {
        # Exactly one matching move, so make it if AutoExpand is on,
        # or if it equals the move entered. Note the comparison is
        # case insensitive to allow for 'b' to match both pawn and
        # Bishop moves.
        set move [string tolower [lindex $moveEntry(List) 0]]
        
        if {$moveEntry(AutoExpand) > 0  ||
            ![string compare [string tolower $moveEntry(Text)] $move]} {
            moveEntry_Complete
        }
    } elseif {$len == 2} {
        # Check for the special case where the user has entered a b-pawn
        # capture that clashes with a Bishop move (e.g. bxc4 and Bxc4):
        set first [string tolower [lindex $moveEntry(List) 0]]
        set second [string tolower [lindex $moveEntry(List) 1]]
        if {[string equal $first $second]} {
            set moveEntry(List) [list $moveEntry(Text)]
            moveEntry_Complete
        }
    }
    updateStatusBar
}

# updateTitle:
#   Updates the main Scid window title.
#
proc updateTitle {} {
    set title "Scid - "
    set fname [sc_base filename]
    set fname [file tail $fname]
    append title "$fname ($::tr(game) "
    append title "[::utils::thousands [sc_game number]] / "
    append title "[::utils::thousands [sc_base numGames]])"
    ::setTitle . $title
    set white [sc_game info white]
    set black [sc_game info black]
    if {[string length $white] > 2 &&  [string length $black] > 2} {
        if {$fname == {[clipbase]} } { set fname clipbase }
        ::setTitle .main "($fname): $white -- $black"
    } else {
        ::setTitle .main $title
    }
}

# updateStatusBar:
#   Updates the main Scid window status bar.
#
proc updateStatusBar {} {
    global statusBar moveEntry
    set statusBar "  "
    
    if {$moveEntry(Text) != ""} {
        append statusBar "Enter move: \[" $moveEntry(Text) "\]  "
        foreach thisMove $moveEntry(List) {
            append statusBar $thisMove " "
        }
        return
    }
    
    # Check if translations have not been set up yet:
    if {! [info exists ::tr(Database)]} { return }
    
    # Show "%%" if base is read-only, "XX" if game altered, "--" otherwise:
    if {[sc_base isReadOnly]} {
        append statusBar "%%"
    } elseif {[sc_game altered]} {
        append statusBar "XX"
    } else {
        append statusBar "--"
    }
    
    set current [sc_base current]
    append statusBar "  $::tr(Database)"
    if {$current != [sc_info clipbase]} {
        append statusBar " $current"
    }
    append statusBar ": "
    set fname [sc_base filename]
    set fname [file tail $fname]
    if {$fname == ""} { set fname "<none>" }
    append statusBar $fname
}


proc toggleRotateBoard {} {
    ::board::flip .main.board
}

proc toggleCoords {} {
    global boardCoords
    set coords [expr {1 + $boardCoords} ]
    if { $coords > 2 } { set coords 0 }
    set boardCoords $coords
    ::board::coords .main.board
}

ttk::frame .main.fbutton.button.space3 -width 15
button .main.fbutton.button.flip -image tb_flip -takefocus 0 \
        -command "::board::flip .main.board"

button .main.fbutton.button.coords -image tb_coords -takefocus 0 -command toggleCoords
bind $dot_w <KeyPress-0> toggleCoords

button .main.fbutton.button.stm -image tb_stm -takefocus 0 -command toggleSTM

proc toggleSTM {} {
    global boardSTM
    set boardSTM [expr {1 - $boardSTM} ]
    ::board::stm .main.board
}

image create photo autoplay_off -data {
    R0lGODdhFAAUAKEAANnZ2QAAAFFR+wAAACwAAAAAFAAUAAACMYSPqbvBb4JLsto7D94StowI
    IgOG4ugd55oC6+u98iPXSz0r+Enjcf7jtVyoofGoKAAAOw==
}

image create photo autoplay_on -data {
    R0lGODdhFAAUAKEAAP//4AAAAPoTQAAAACwAAAAAFAAUAAACMYSPqbvBb4JLsto7D94StowI
    IgOG4ugd55oC6+u98iPXSz0r+Enjcf7jtVyoofGoKAAAOw==
}

image create photo engine_on -data {
    R0lGODlhGAAYAOf4AFFOdGdOTQBk9AVi9ItNEVhVfAVt8FVafwRt91ZbgGhZYVdcgZNTEF1a
    gVtghV1ih15iiGNjg2ZmhlJrpDB01mdnhxV8+J9iFV1rm2lpimZqkGpqi2trjG1tjm5uj7Fl
    CnBwkXFxkrZpAXJyk2Z2oDeB6nNzlHR0lXV1lnZ2l3B4pDKI+LBwJTSJ+Xx4lHl5mjaK+nN7
    p356l397mIB8mYF9mpF8ebx6KECS+4KGoYOHooaKpUmZ/IeLplSW+2KU5omMp8qFK4uOqZmN
    jXSUz4yPqo2Qq1Ki/tCKKJKSqFOj/9mLGFSk/5+Tk5WVq1+j+5SXs2Ck/JeXrZWYtGGl/ZiY
    ruGRFFqq/3Sj5JqasGSn/+WUBpycspSfuWet/o2i05+ftqCgt42l0Gqv/2uw/6OiuYyp2aSj
    up+mu3Sx/YGv8KamvPSgDaqmt+iiJZ6qxG+3/3ez/6unuHC4/3i0/6mpv4mx7JOw4e6mH8Op
    iKurwXq6/5ez13u7/328/7Guv7KvwKizzrOwwYa9/YDC/6W40Za76+6uQYe//4HD/7ezxIjA
    /8Kzrpi+7bm1xrq2yIrF/ru3ybO60IvG/7y4yrS70ajA37i8zI7I/7K92LO+2Y/K/7q+zr+8
    zZbK/rvAz5DO/5HP/6XJ7L/D0pnO//zASZnR/sHF1aTO95rS/8LG1pvT/77K2MfI0p3V/8XJ
    2cLK36LV/L7N4aPW/crL1aXX/7zQ6cjN3KbY/83N1/TLeKfa/87O2c/Q2qfe/q7b/dDR26jf
    /9HS3Kng/9LT3avi/8vX5f/Yb7Pl/7Tm/7Xn/7ro/Lvp/b3q/vzhkL/s/8Tt/PnjpMXu/cbv
    /sfw/8jx//7ti8nz/8n2/cr3/9D1/tzw/dbz/sv5/9H2/9f0/9n1/9T5/9r2/9v3/9L8/efz
    /9/4/dr7/uH5/tz9/+j5/93//+n6/+L//er7/+j+/f/9xu/8/en//uv///H+//L///n///7/
    /P///////////////////////////////yH5BAEKAP8ALAAAAAAYABgAAAj+AP8JFJgFzCdH
    fwYqXKgwh5M3sri5s1eOFa1ODBnWCJOkWjVw6tTF2wbrVsaFNYRg8ugNHbpx4LTJonRyIAlM
    ppA9q8at2rdnzZDlwnjSA5FFoHAla7YTaLJfgUyezFCCDqZauIYpe7bs165Vd4QpOpkCAQIL
    POjMGePlCp1FntS8EnQSggELMLSM6bNoUZ8xT5RgaaXnZAQKJXy89YQL16o+dJR84SSnJoQf
    XkgNexYuXLdfnvpIAlPznwYMaoZVI9cOXbpmsQy1Kf1vgQYVw7ylu2dv3jRRVeoAol17RIou
    tyqhqZJERy8gNqzQbmAix4wkRlz868BhSBA30mlDR8jgwcNABSx0WcMTnrhCAh/YOINnrb17
    gfBLzQd//z0b/evZdx988tHX33si6BdNHgcORAAbh9yQRYMKBQAAhScFBAA7
}

image create photo engine_off -data {
    R0lGODlhGAAYAOfyAOYFO+YGQOgINugJPOcKQVFOdOkOPeAUOWdOTeAUPgBk9AVi9LUpUuEX
    P+AXRItNEeIZQM8hTVhVfOIaRdgeTAVt8FVafwRt9+IdS+UeQuQeR2hZYVdcgZNTEN4nUFtg
    hdUrWM8vVuEqTV5iiOEqUmNjg+MtVGZmhlJrpNY2WjB01mdnhxV8+OYwVp9iFd81WV1rm2lp
    iqtNcd82X2pqi2trjMlCdG1tjm5uj7FlCuQ8Y+Y9X3BwkbZpAb5NhWZ2oDeB6nNzlNxGaHR0
    ldNKdoZtj3Z2l6hdnHB4pDKI+LBwJTSJ+Xl5mjaK+nN7p356l+ROb4B8mdpWc4F9mpF8ebx6
    KECS+61wjIKGoYOHoqt1oIaKpUmZ/K12roeLplSW+2KU5omMp8qFK4uOqZmNjXSUz7J+nY2Q
    q9CKKJKSqNmLGJ+Tk5WVq8eAmV+j+8p+n8SDmpSXs2Ck/GGl/ZiYruGRFNZ/mJqasGSn/+WU
    Bpycsq+UxJ+ftqCgt42l0L6Uqmqv/9OLpGuw/6OiuaSjuqamvPSgDaqmt+iiJW+3/3ez/72b
    wXC4/3i0/6mpv4mx7NGYspOw4e6mH8OpiJWv53q6/9absLGuv7KvwKizzrOwwcSnxYa9/YDC
    /5a76+6uQYHD/4jA/8Kzrpi+7bm1xrq2yIrF/ru3ybO60IvG/7y4yqjA37i8zLK92Nmuw7O+
    2Y/K/7q+zr+8zZbK/rvAz5DO/5HP/6XJ7MW91r/D0ueyxPzASZnR/sHF1aTO95rS/5vT/8bG
    3bjM5cfI0p3V/8LK36LV/L7N4crL1aXX/6bY/83N1/TLeM7O2c/Q2qfe/q7b/dDR26jf/9HS
    3NLT3avi/8vX5f/Yb7Pl/7Tm/7Xn/7vp/eLb5/zhkL/s//njpMXu/cbv/sfw/8jx//7ti8nz
    /9bz/tH2/9f0/9n1/9v3/+fz/9/4/eH5/un6/+r7///9xu/8/f//////////////////////
    /////////////////////////////////yH5BAEKAP8ALAAAAAAYABgAAAj+AP8JFHiHDy1S
    lwYqXKgQCxszL3TEi7cuFzJZDBlO6ZPGDoAD7ty9Q1esWcaFU8aMgiTgALd27dKNO6bq5EAn
    sHwV03DAgCtz3rxhW4bxJI4ynWxJe9PyRVBs0DKZFChAgMIVQBqlUiYthQADm6BJA+Zp2Z+W
    B6oONHKhAgs3eBq1zCAoFaWPX3suHOG2iZxGldIKOBJhQloDVa0qLKGiCZdEnWqJEJxXgAab
    I8AA8iVtnIaqaR2g4mPzXwkYjaQFa1FZyqhDpf9JuPFjMmUNt+IUwlR6QE+0gQLxDIHFWRgq
    dU4KPhBBBpYsXg/gqEFGDKLkDA+kFbiCRo0IajdFKGFGThL22FSrPshhqBs8cudjo/23fpf7
    6+j/JRb4wJD98vGdBNpA67X3Xn7bEdiDfd9Mgh5iC/X3SRV35HcSAgVYiF5AADs=
}

image create photo finish_on -data {
    R0lGODlhGAAYAOfwAJbK/np6dkJCOh4qQo62+mZmXsrKyoaGgi5Cbtra2qKinhIWSmJiWkpq
    nlp+utri8p6amiI2UjI+rkJajmJiXiY6VqaiokJiyjpSfuru+iImbl6GxnKe8ra2shIeMiYq
    eprG/mqS5iYufmqG/j5OugoODioyhkpmzkJWsvL2/jpaxsLK6jpKtkpGRlJyrl6C3mJ6/mKG
    znqq/jo2Ni4yqhYSCrrC5jpGsgoOMk5qzl6G3vb6/lJSTlp6xjI6lm6a6sbGwjI6mmKK4mJy
    ylp+2lJuzhoeGjZKdnKC0kpexjY+uuLm9m5uapKOjgYOIk5i3lJm5kpa1tLS0sbS8jI2pnqm
    +jJCttba8m6G1prK/hISDhIaKr6+viYmHgYGBmaK7qLO/kZawurq9oKy/i42qlpyzmqO8lp2
    0maO4kJSvnqi7vr6/jY+ss7O6lpWUlJy0lZ61jY6rjpCshYWDoKCfgoWJtLW8nKa8goKDnae
    9l5+1h4aGm6W6maK4lp61lJiwu7y+io6skJWvm5qaoKq8jI6qoJ+fjo+rg4OFmaG3iIeHlZy
    2rq6tkpiwv7+/j5Gvnai9gYKDt7e3n5+es7Oyubq9tbW1qLS/s7S7jZCslZyzmqK3i5GcmqK
    /jZOdhIWEl561nai/k5m0kZWxvb2+j5KtnKe+gYOFhYWFh4uRoq6/qamoj46NnJyapKSjmqO
    7l5aVjY+qmJ+2mKC2mKG3mqO4nqi9jJCdjY6sgoKEm6W8k5iylZy1kJOuk5mylJqynKa6lZu
    zjo+vtbS0p7K/vLy+kZWvjY+tk5exsK+vg4KCi46rgoOFmKC3mqS6l5+2jY+rjpGtmaK5jZC
    tl6Gyurq+lp21nKa9jI6rnai+s7OzlZy0mqO5kJCPmZmYhIWTra2tkpa2jI2qnqm/hISEiYm
    Ilpy0jpCtrq6ugYKEvb2/j5KulJqznKa7kZWwgICCv//////////////////////////////
    /////////////////////////////////yH5BAEKAP8ALAAAAAAYABgAAAj+AP8JHEiwoMGD
    BbUdgNWthTcFkhAaTDbjFCcX1DY0iOBlUAKJAidFcgAADBhbHCDJqOIJFReJFDyoApMFBIgQ
    OPm0G0etBLqDTeqMuUSMGAEhOmj1QcPNGaQYWoYVTKDsxx1CamoR2ZRhExFaifqEyDbBTUEm
    nvL0efHsmZ8pjnbIgvOsGa0QMvBQIogKGLdZevxY4/UmhSNSoN74qXsNg6GBUt6FmmWtyIkL
    F1RocuQoRZkc5kBJi8FqILhU186wwwJoiesH6jgXC+Zr2zNTewauqvCqSBIknIMLtxOmtqka
    AxkN+ILM3ZArmKKvKMa5mqA0YX7pUjTQEjMzxta1RZtmxUqgP5zFkGBBoteuHgIIlpuVBpqc
    GyyilVrjqFK0TJlAE4soRxxA0CQIjFJIHNBAI4ENjoiRyTJxiBMFFIsgIkVBnzSCSxwgknFI
    G9DQEAcVT4wAwy0UGGTBFo+wAWIcZNQIYiGdjICCER8ZFIAT5xzz4YwgYhNOEOQAIZEruYgg
    jBLHsMHGMcIc800XBoD0jzY8pLPABz6YoAEOc9ChJUEJQNAKAwVM0sGZcMYpp0ABAQA7
}

image create photo finish_off -data {
    R0lGODlhGAAYAOeVAAMDAwYGBgkJCQoKCgsLCwwMDA4ODg8PDxERERISEhQUFBUVFRYWFhkZ
    GRsbGx0dHR8fHyUlJSYmJikpKSwsLC0tLTIyMjMzMzQ0NDc3Nzk5OTs7Oz4+PkBAQEFBQUJC
    QkNDQ0REREZGRkdHR0hISElJSUpKSktLS0xMTE5OTk9PT1BQUFFRUVJSUlNTU1VVVecQOVZW
    VldXV1lZWVtbW1xcXF1dXV5eXl9fX2FhYWJiYmNjY2VlZWZmZmdnZ2hoaGlpaWpqamtra21t
    bW5ubm9vb3BwcHFxcXNzc3R0dHV1dXd3d3h4eHl5eXp6ent7e3x8fH19fX5+fn9/f4CAgIGB
    gYKCgoODg4SEhIWFhYaGhoiIiImJiYqKiouLi4yMjI2NjY6Ojo+Pj5CQkJOTk5SUlJeXl5iY
    mJqampubm5ycnJ6enp+fn6KioqOjo6WlpaampqysrLGxsbOzs7a2trq6ur6+vr+/v8DAwMHB
    wcPDw8TExMbGxsjIyMrKys7OztHR0dLS0tPT09TU1NbW1tjY2Nra2tvb297e3uHh4efn5+rq
    6uvr6+zs7O7u7vLy8vPz8/b29vn5+fr6+v7+/v//////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    /////////////////////////////////yH5BAEKAP8ALAAAAAAYABgAAAj+AP8JHEiwoMGD
    Bf9oofFhRI82iBAavJOhQIgiVar0uBBAiCGDMGAMlCLACR4+fNigWfOmzQkGdkISDAlDx4M5
    fPLcuSOmJxkzbarIBKkgTh89euRswZKFixcwY0ImEFTQEIGQcNZ8idLFUZcoWbSEXDNDRkEi
    J9SEnDLlSSBKkqg0CZlFzJsBfwgyMAPGCk0lSCJRigQFxpMpV86smDIwEAA2VpgYARKyRhJK
    IZUMUQKFy5UNA+lQOMOEyJZHikImCkkJ0pEgSaakcTAQToYwRnZoocQbM4zehXDATpNgYJ0J
    XXjYWHJokHOalBrRmIFjSBkIAwkZCGPDhYoTJkypwPjh+wWLFzF8NPFAUIKVGSRQpGABo8Uk
    SotCniAxQkgJLQRJ4cENIYhAQkh7UMLICSCEtAMRShwQSEEK8CCCCDCI0EEJgJDAgQgeBBES
    CDoY5EYD9GWoYQcdXBgCGF6E9JFBToRUwoU4urjDBwnQdBAMBGBwQgklkEBCCUM6EIEfAg01
    UEh/tDCAAxZ8oEEFCCxghUT/OGlIGkfkwIMUdHDZpJlopnlQQAA7
}

image create photo comment_avail -data {
    R0lGODlhEAAQAMZCAAAAAAUDAAgFABkSAxwWBk07FE47FXVTBq58Da98DryFCrmHGMiZNeGvSdmx
    YduzY+SzT+S0Uc+5i+q3UOu4U+q5Vuu5V+S6Zuu6V+G7bOu7Wu27WOy8W+28Xee9Z+y9Xee+bOi+
    bOe/bum/bdvHmuzSne3Tne3Tnu/Xp+/XqPDYqPDZqPbjv/bkwPbnx/fnyPfoyfjqzvjqz/nt1vrt
    1vz26fz26vz37P337P337f779v779/78+P78+f79+v79+/79/P/+/f//////////////////////
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////yH+
    EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAQABAAAAeAgH+Cg4SFhn8TGhwaFIeDFyYu
    My8nHo4hLDU6Pjo1LCOGFSg3PkCmPzcqFoUfMTymQUFAPTIdrDI9QLGxtLaEGCk4P7qyOSsbhiAs
    Njs/OzYtIo4PJS80MCYOjn8GGREQDQwF238EJAkIAwTbABILCgoHAOQAAgEB8+R/APz6+oEAOw==
}


image create photo comment_unavail -data {
    R0lGODlhEAAQAMZBAAAAAAEAAAMCAAQDAgUDAAUFAwYFAwYFBAgFAAkIBQwLCA0LBhANBQ8ODA8P
    DhQSCxkXEFhQMnVTBmJaPmtfOXJnPpFmB3ZwWaV0CIF5XYB/fYWBc46CWbyFCr6GCrmHGJ2PWZ6Q
    XJmUh6OXbKGZeJ2ajsucNaOhm8+5i9PAlNvMrNLQyeDRnePSleTTmOPVo+XWoeverujet/Dfo+rg
    u+rhxfLktOnk0+/lvOjl2/XouPXpvvbqv/bqwPbtzvnx1vr14P//////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////yH+
    EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAQABAAAAdxgH+Cg4SFhoeIggoHAAUHiX8D
    FzI7LBMAiAAZPkA/PDMRmIYAODkaKycxIaKFADY1NxsiLyCshAAjOj00JS4UtoQFHC0wJBXAhA4Q
    DwALCQ2JACkmHh4WAZAGKhgYAgzRKB8dHRLItwgEBOatAOuQhIEAOw==
}


#----------------------------------------------------------------------
if {$png_image_support} {
	image create photo autoplay_off -data {
		iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJ
		TUUH1wgGEBoIdCRDswAAAfFJREFUOI3Nkj9oE3Ecxd/vcsmludwvDSbNJdczhcIFHbRdUoQMVWJ1
		FdwciqDGQofQLnZsB0E61HawYokgiGgh/hlEYzvEpCkojWdHDYiXNKRYBxG8RE9zTldKYlB08cEX
		3vI+PL7fL/CPsu3xQQD7AJgAvv0NQBw5EX8XDu/3Eo7RlH6lUa1Wv/4xQBAEvyz3jk9MTg5slbfO
		MDamMRQd+hSNRhuqqnZsRCwTiUQOhfvkzczTFVQqZaQfpI1sNvtW7OmZU5QDG263u5RIJPRWAGOZ
		YDDoAIByRcPaeg7H43H7/Nz8wa4u1+LrTfUyx3Gn8vn84VKpxP0SIEkSBwCsjQXv4lHbrmHn4w65
		NDVlTyaTJ3O55zdWV5+N8zx/2jRNpQ0QCAQcAMCyLATqARUonE4ndF2H3CszqdRNl1bWzj18dH8Y
		wJE2gCiKnAWglO4ZD2rbtebYWKI+ODB468L5i+sAXlg5tnUHLGuHh3rg7fZCr9cxO3vFaJpmYWZm
		Ou33i0UAKiGk0QYIhUIcAFBKYXw3sLx8z3hVLGqjo2dvx2KxPIANQsjn1ivsAiRJcgBAobD2Y/H6
		tS/DR4/dWVpKPQbwkhDyoTXYsUFmJfPk6sLCXZ/XVyCEvO8UtLT7SKZpjgDwAVABvCGENH8X/j/0
		E6ShmjXfUKodAAAAAElFTkSuQmCC
	}

	image create photo autoplay_on -data {
		iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJ
		TUUH1wgGEBoIdCRDswAAAQ9JREFUOI3VkjFKxEAUhr/3Zsi6mS6NW6wJJKnU0lOIeArFTvEe6mFE
		PIOiXY4gLGEL29iNxWyGhMi6nfgzj3kD///NGxj4a8mgz4C9HTJfwGd/sH0zn8/Ts/PTj9/ST4/P
		B13XTQF1XScA93cPiAiCEFYYUkS4ub2mruukaRomgDzPZwAqyuvbC9ZarLFht5ajw+Po+xFQlmXS
		rleICs65GDYbgBoTfcMnRUBRFEm7XqGquNTFm00P2gCKohgBdDDBDMCoIXWONA3lXCijOvJNJqiq
		KgEwxsQJVCMf7/3INwEsl8sIWOwv8CEVwpsa+iaALMsswOXVBdvU+3rFn+i9PwEWW9NBrYi87+D7
		L/oGx9IwzmkU3BMAAAAASUVORK5CYII=
	}

	image create photo engine_on -data {
		iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QAAAAAAAD5Q7t/AAAACXBI
		WXMAAAsRAAALEQF/ZF+RAAAEoUlEQVRIx7WU328UVRTHv+fOzHbZbru/6Lbd2R/9gQXbgkCXmD5A
		4oM1xmACWqOEVPBB34klmBpMjBiEwD/QBwgaTdkWxV/RYOIDIY0h2FZLC9J2p7s7K1vY3XaXWLo7
		M9cHZsmK26ok3uQkk3vnns8553vOBf7nRasdHD9xbDeAXgDdAILmdgzAKIDIkcMDXz0W4PiJY9sA
		nCYm+uoagkZAlus9rtpagCOdzefiqpq6czvGuKElARw6cnhg7F8DzKgjXl9LdEtneyCWNpTFZSwV
		NCoCgEXkknMdOUIe1jQxeT2+kJxrBtC7VjZU5nwbgNHWjVsX7G5/cT7NExwwVrnEmjzkz2dUafbm
		mBdA92qZiGXfp+vl1miN22+JpnmstDmbXHRPz2dkAGgPedQWnyPDASOa5rFmjxysl3PRlDp7GsAz
		lQCsVBpiom9rZ0dASfPEgygJjBFuzGflwf4eDPb3YHo+IwsCg8AYiBGUNE9s3dwZIEH0meWtDADQ
		621sMqJpQ+GAwRiBlRwR/mKiwMAEBpExMIEZyl1d8TY0GWbHrVqi7lDA71FyfJoxhrnkontKScsA
		QEQgeiAVEeGLyzObAaCzeb3aKjszuRVjKRT0P5lSZ7rXAgTr3A5hZlEvMkaYUtLyYH/PwxYodcJg
		/7MAAA7gzZOX5LagOxNbuJftCjlrAVSvKbIZXdTf4LQuF/RNmmEIAmNERFQicM65wTnXDa7n/ygY
		n1+Zm9U0nfaEa1br0oeA2J3skidUX11zK5nLaAbGe49+3U5EAAEfDzwPAOj78DuAAxwcdpt1yuBk
		PNFY485kczkA6bUAo7F4Yke4LRSYXVjJ2K1S3OWyxyVJhJpMP1cCERFamuq/1zUdBV1Hsahh+4ba
		gBKPpgBcXauLIqmkwnZscHTYrIIoCAJExiAJ7KHIRARGBEkSIYgCBMZQXSWJ25prOm6rUQYgUglQ
		Psk/yqGNDW5fGwZ/UC9XWSRIFhH5e/cD2cV8OwHw1jmn3E57vFDUUCho6NtZt/NO4iYSyo3bRw4P
		VBy08kk+pM7fHHU4nAtv9QR2fnZlYdQgaOvd9rivwRW3SCI451gpaLBKTHytu6G7sKRWJ5QbXgD7
		VhO54mPnb94U3b7lqcCkunz9t9/vx1N5fUlgAhpdoqPNawlsbLR2jE9MJGLR6SYAVdeu/Zyvqqoa
		/+Tcp7vWBACg9z94b7skSacE0eKTg61GcyhUv97lqAGAu9mlvBKLpxLzt5iuFZIrKytvT05eHz74
		xuuh8bEJjI9PKJGhkRZzVP4GIFN0BoC9e/Sd3VardS9j7GnGmB8ADMNI6Lp+NZfLXzz50alvAWDf
		/lcHbTZbbz6Xv993YL/17JlzucjQiONRQMm5YOryqJXAkmmEB0+5BkB7+ZW9Y+Fwl2vm1lxhz0sv
		Ws6eObccGRqxPSoymQCpggmmrQNgNWEGgAKA4vD5C7sA/BQOd9m+vPiNceBg3zoA9yJDI/ZywD8t
		DkAHUCwDGOY+Hz5/4XkAl8LhLsuvv0xWbNNyB9y8rJtlYGaGy2YmVCZk6d/M8PkLYQCXiKguMjTy
		wn8I/vHXn4Y12hGK1zC4AAAAAElFTkSuQmCC
	}

	image create photo engine_off -data {
		iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A
		/wD/oL2nkwAAAAlwSFlzAAALEQAACxEBf2RfkQAAAAd0SU1FB9oCHAwWC50uu5UAAAUJSURBVEjH
		vVV/TFNXFP7ufe+V0lqgVFt+tBRFJaEwldYpbjMxuODmcJGBIUoQpiZzW7ZJnLrgzP6YkWlkicnm
		nDrBmSkWUFimc2xZ2I8gMwqoWxSR1haQKgVpEUr7+t7+4JEQtOiWbCc5eS/3vXu+853v3HOB/9hI
		qA9le3dnA8gDkAEgQVp2AGgCYN2xrfTbfwVQtnf3AgDlhLJxM2ISBEN8vE6jjogARLgHvB5nd7fr
		fq+DigLfA6Bkx7bSlqcGkLK2auNm2Z5JTTE43IL9wQgG/TwJAICMFbmocBJp1NDEtut/Ou/1dM4E
		kDcVGzIp86ak5Pn3pkXrA3fcYpcICCE20UQN0Xv7u7nbN1u0ADJCMaET3st18Uk2VbQ+YHeLjkeC
		EwJCxvIRAcHmFh2q6PiALj7JBqA8FAM6XhpC2bj5qSaD77OPZCkfvrDEcOjtFCoGCcNQMAwFy1Aw
		lIJSQFe2bt7s7c8/N3qgNGx+WqqBMGycVN6QDPK0sYmCzS3YVW0/6pae2CnLevGuxnBws4kRBcIy
		DFhmLHjc55tN2em2iOUVGzjFtUatvS9o18YkClLHhQTIMBr0ugfD4uBw8uI+f/0BgV1Rwix7ZVCD
		sk0ZdY030mob29OEPRuXZC64PZ0tfpfxWysFX/LiPs8oGTQm6HVSOz9irPRMmBEdyXQ8CAZcG/a1
		V+7ZpNmo+pSTr9hOitn93LymwyoBBOaVPRzNeouIdV+IlRfn8LLS/e3O+8NDZmNUBADlVAAghODs
		rx02fUyU3Pbs1v55fxxVLxTLZCSrhKSrj3MQeZCUN4j4/Zdi802T/5R5g1t10dHB80Gy2qLClCID
		cNwfGPQYdUpVZ4/HGwDTukVV6DpyQuEbbasQiSmXkJRc4murFg9bVb6t6mIXKw+/KohEmBOriuwf
		8HikUx4SoMnh7HJZ5qoNlKGYppQ7tbHRF5SseJf2DwXBDwNBH1jvw6CKQ68xQXchMkrpZFiK9NkR
		BruzyyWNkJAAVlePnS6cHWlSyBmWUoK8c+9n5i5xGLhFOSx/xcrzV6w8uzCbzU236V+ueW85JYAy
		jGMXzFSZerttFID1SSf553hjcow6dg7cW9dx+ekdCbKizVzgh2/4s/UqF6VUWJXZF8utzGNHjx4L
		1Pw116kpP+nv625Hl/1G745tpcumFBlASfedm03a2kP8mtTb4bKC9ZSvq+DPNGhcjUWV52UcC/Gr
		wqxXR0/GhhWv43IrTyU2Htgy0mVexgJY+ySRIc2SPLT+rpAX5VPhQi0amhMe3nrn62aGZSgIpZ1b
		Tlz66frcIaH+DGTr8ynf8psSQNjly1caCwrX/vI045qcT4s6yY36cjw6g3/4zY+7ZyUlaaerI1UA
		0Dcw6LXb7C7ZwV3xyq4OOQkLrztiyrQUv77e2NrShtbWNru1qmbW2Lh6FIBIjCgAunPXB9lyuTyH
		UrqIUqoHAEEQuoLB4CWPx1u375P95wBgbUH+YYVCkef1eH2FRQXyimPHPdaqmsjJAOPBGUmXyT4O
		zElOMDZteQB87pqcFovFrO641elf/doqWcWx4yPWqhrFZJGJBMA9xhnJwwHIJTABgB9AoPp07VIA
		zRaLWVFf951QVFwYDmDIWlUzjf0H97cIIAggMAFAkNbF6tO1LwFosFjMsmtXrz+2TScGEKXNQakM
		VGI4IjEhE4Qc/7e/+nStBUADIWSGtapmJf4P+xvUwP3l4H0SQwAAAABJRU5ErkJggg==
	}
}

#----------------------------------------------------------------------



	
button .main.fbutton.button.comment -image comment_unavail -command {makeCommentWin}
button .main.fbutton.button.autoplay -image autoplay_off -command toggleAutoplay
button .main.fbutton.button.trial -image tb_trial -command {setTrialMode toggle}
button .main.fbutton.button.hgame_prev -image tb_hgame_prev -command {::game::LoadHistory -1}
button .main.fbutton.button.hgame_next -image tb_hgame_next -command {::game::LoadHistory 1}

foreach i {start back forward end exitVar addVar comment autoplay flip coords stm trial intoVar hgame_prev hgame_next} {
    .main.fbutton.button.$i configure -takefocus 0 -relief flat -border 1 -highlightthickness 0 -anchor n
    bind .main.fbutton.button.$i <Any-Enter> "+.main.fbutton.button.$i configure -relief groove"
    bind .main.fbutton.button.$i <Any-Leave> "+.main.fbutton.button.$i configure -relief flat; statusBarRestore %W; break"
}

pack .main.fbutton.button.start .main.fbutton.button.back .main.fbutton.button.forward .main.fbutton.button.end \
        .main.fbutton.button.space .main.fbutton.button.intoVar .main.fbutton.button.exitVar .main.fbutton.button.addVar .main.fbutton.button.comment .main.fbutton.button.space2 \
        .main.fbutton.button.autoplay .main.fbutton.button.trial .main.fbutton.button.space3 .main.fbutton.button.flip .main.fbutton.button.coords \
        .main.fbutton.button.stm .main.fbutton.button.hgame_prev .main.fbutton.button.hgame_next -side left -pady 1 -padx 0 -ipadx 0 -pady 0 -ipady 0


############################################################
### The board:

proc toggleShowMaterial {} {
    if { $::gameInfo(showMaterial) } {
        grid configure .main.board.mat
    } else  {
        grid remove .main.board.mat
    }
    updateBoard
}

::board::new .main.board $boardSize "showmat"

#.main.board.bd configure -relief solid -border 2
::board::showMarks .main.board 1
if {$boardCoords} {
    ::board::coords .main.board
}
if {$boardSTM} {
    ::board::stm .main.board
}

if { ! $::gameInfo(showMaterial) } {
    grid remove .main.board.mat
}

# .gameInfo is the game information widget:
#
autoscrollframe .main.gameInfoFrame text .main.gameInfo
.main.gameInfo configure -width 20 -height 6 -fg black -bg white -wrap none -state disabled -cursor top_left_arrow -setgrid 1
::htext::init .main.gameInfo

# Right-mouse button menu for gameInfo frame:
menu .main.gameInfo.menu -tearoff 0

.main.gameInfo.menu add checkbutton -label GInfoHideNext \
        -variable gameInfo(hideNextMove) -offvalue 0 -onvalue 1 -command updateBoard

.main.gameInfo.menu add checkbutton -label GInfoMaterial -variable gameInfo(showMaterial) -offvalue 0 -onvalue 1 \
        -command { toggleShowMaterial }

.main.gameInfo.menu add checkbutton -label GInfoFEN \
        -variable gameInfo(showFEN) -offvalue 0 -onvalue 1 -command updateBoard

.main.gameInfo.menu add checkbutton -label GInfoMarks \
        -variable gameInfo(showMarks) -offvalue 0 -onvalue 1 -command updateBoard

.main.gameInfo.menu add checkbutton -label GInfoWrap \
        -variable gameInfo(wrap) -offvalue 0 -onvalue 1 -command updateBoard

.main.gameInfo.menu add checkbutton -label GInfoFullComment \
        -variable gameInfo(fullComment) -offvalue 0 -onvalue 1 -command updateBoard

.main.gameInfo.menu add checkbutton -label GInfoPhotos \
        -variable gameInfo(photos) -offvalue 0 -onvalue 1 \
        -command {updatePlayerPhotos -force}

.main.gameInfo.menu add separator

.main.gameInfo.menu add radiobutton -label GInfoTBNothing \
        -variable gameInfo(showTB) -value 0 -command updateBoard

.main.gameInfo.menu add radiobutton -label GInfoTBResult \
        -variable gameInfo(showTB) -value 1 -command updateBoard

.main.gameInfo.menu add radiobutton -label GInfoTBAll \
        -variable gameInfo(showTB) -value 2 -command updateBoard

.main.gameInfo.menu add separator

.main.gameInfo.menu add command -label GInfoDelete -command {
    catch {sc_game flag delete [sc_game number] invert}
    updateBoard
    ::windows::gamelist::Refresh
}

.main.gameInfo.menu add cascade -label GInfoMark -menu .main.gameInfo.menu.mark
menu .main.gameInfo.menu.mark
foreach flag $maintFlaglist {
    .main.gameInfo.menu.mark add command -label "" -command "
    catch {sc_game flag $flag \[sc_game number\] invert}
    updateBoard
    ::windows::gamelist::Refresh
    "
}

bind .main.gameInfo <ButtonPress-$::MB3> "tk_popup .main.gameInfo.menu %X %Y"
# alternate code that may work better on MacOS ?
# bind .main.gameInfo <ButtonPress-$::MB3> ".main.gameInfo.menu post %X %Y"
bind $dot_w <F9> "tk_popup .main.gameInfo.menu %X %Y"


# setBoard:
#   Resets the squares of the board according to the board string
#   "boardStr" and the piece bitmap size "psize".
#
proc setBoard {board boardStr psize {rotated 0}} {
    for {set i 0} { $i < 64 } { incr i } {
        if {$rotated > 0} {
            set piece [string index $boardStr [expr {63 - $i}]]
        } else {
            set piece [ string index $boardStr $i ]
        }
        $board.$i configure -image $::board::letterToPiece($piece)$psize
    }
}

# updateVarMenus:
#   Updates the menus for moving into or deleting an existing variation.
#   Calls sc_var list and sc_var count to get the list of variations.
#
proc updateVarMenus {} {
    set varList [sc_var list]
    set numVars [sc_var count]
    .main.fbutton.button.intoVar.menu delete 0 end
    .menu.edit.del delete 0 end
    .menu.edit.first delete 0 end
    .menu.edit.main delete 0 end
    # PG: add the move of main line
    if {$numVars > 0} {
        set move [sc_game info nextMove]
        if {$move == ""} { set move "($::tr(empty))" }
        .main.fbutton.button.intoVar.menu add command -label "0: $move" -command "sc_move forward; updateBoard" -underline 0
    }
    for {set i 0} {$i < $numVars} {incr i} {
        set move [lindex $varList $i]
        set state normal
        if {$move == ""} {
            set move "($::tr(empty))"
            set state disabled
        }
        set str "[expr {$i + 1}]: $move"
        set commandStr "sc_var moveInto $i; updateBoard"
        if {$i < 9} {
            .main.fbutton.button.intoVar.menu add command -label $str -command $commandStr \
                    -underline 0
        } else {
            .main.fbutton.button.intoVar.menu add command -label $str -command $commandStr
        }
        set commandStr "sc_var delete $i; updateBoard -pgn"
        .menu.edit.del add command -label $str -command $commandStr
        set commandStr "sc_var first $i; updateBoard -pgn"
        .menu.edit.first add command -label $str -command $commandStr
        set commandStr "sc_var promote $i; updateBoard -pgn"
        .menu.edit.main add command -label $str -command $commandStr \
                -state $state
    }
}
################################################################################
# added by Pascal Georges
# returns a list of num moves from main line following current position
################################################################################
proc getNextMoves { {num 4} } {
    set tmp ""
    set count 0
    while { [sc_game info nextMove] != "" && $count < $num} {
        append tmp " [sc_game info nextMove]"
        sc_move forward
        incr count
    }
    sc_move back $count
    return $tmp
}
################################################################################
# displays a box with main line and variations for easy selection with keyboard
################################################################################
proc showVars {} {
    if {$::autoplayMode == 1} { return }
    
    # No need to display an empty menu
    if {[sc_var count] == 0} {
        return
    }
    
    if {[sc_var count] == 1 &&  [sc_game info nextMove] == ""} {
        # There is only one variation and no main line, so enter it
        sc_var moveInto 0
        updateBoard
        return
    }

    set w .variations
    if {[winfo exists $w]} { return }
    
    set varList [sc_var list]
    set numVars [sc_var count]
    
    # Present a menu of the possible variations
    toplevel $w
    ::setTitle $w $::tr(Variations)
    setWinLocation $w
    set h [expr $numVars + 1]
    if { $h> 19} { set h 19 }
    listbox $w.lbVar -selectmode browse -height $h -width 20
    pack $w.lbVar -expand yes -fill both -side top
    
    #insert main line
    set move [sc_game info nextMove]
    if {$move == ""} {
        set move "($::tr(empty))"
    } else  {
        $w.lbVar insert end "0: [getNextMoves 5]"
    }
    
    # insert variations
    for {set i 0} {$i < $numVars} {incr i} {
        set move [::trans [lindex $varList $i]]
        if {$move == ""} {
            set move "($::tr(empty))"
        } else  {
            sc_var moveInto $i
            append move [getNextMoves 5]
            sc_var exit
        }
        set str "[expr {$i + 1}]: $move"
        $w.lbVar insert end $str
    }
    $w.lbVar selection set 0
    # bindings
    bind $w <Configure> "recordWinSize $w"
    bind .variations <Return> {catch { event generate .variations <Right> } }
    bind .variations <ButtonRelease-1> {catch { event generate .variations <Right> } }
    bind .variations <Right> {
        set cur [.variations.lbVar curselection]
        destroy .variations
        if {$cur == 0} {
            sc_move forward; updateBoard -animate
        } else  {
            sc_var moveInto [expr $cur - 1]; updateBoard -animate
        }
    }
    bind .variations <Up> { set cur [.variations.lbVar curselection] ; .variations.lbVar selection clear $cur
        set sel [expr $cur - 1]
        if {$sel < 0} { set sel 0 }
        .variations.lbVar selection set $sel ; .variations.lbVar see $sel}
    bind .variations <Down> { set cur [.variations.lbVar curselection] ; .variations.lbVar selection clear $cur
        set sel [expr $cur + 1]
        if {$sel >= [.variations.lbVar index end]} { set sel end }
        .variations.lbVar selection set $sel ; .variations.lbVar see $sel}
    bind .variations <Left> { destroy .variations }
    bind .variations <Escape> { catch { event generate .variations <Destroy> } }
    # in order to have the window always on top : this does not really work ...
    bind .variations <Visibility> {
        if { "%s" != "VisibilityUnobscured" } {
            focus .variations
            raise .variations
        }
    }
    bind .variations <FocusOut> {
        focus .variations
        raise .variations
    }
    
    # Needed or the main window loses the focus
    if { $::docking::USE_DOCKING } {
        bind .variations <Destroy> { focus -force .main }
    }

    catch { focus .variations }
    catch { grab $w }
    update
}
################################################################################
#
################################################################################
# V and Z key bindings: move into/out of a variation.
#
bind $dot_w <KeyPress-v> { showVars }
bind $dot_w <KeyPress-z> {.main.fbutton.button.exitVar invoke}

# editMyPlayerNames
#   Present the dialog box for editing the list of player
#   names from whose perspective the board should be shown
#   whenever a game is loaded.
#
proc editMyPlayerNames {} {
    global myPlayerNames
    set w .editMyPlayerNames
    if {[winfo exists $w]} { return }
    toplevel $w
    ::setTitle $w "Scid: [tr OptionsBoardNames]"
    pack [frame $w.b] -side bottom -fill x
    
    autoscrollframe $w.desc text $w.desc.text \
            -foreground black -background gray90 \
            -width 50 -height 8 -wrap word -cursor top_left_arrow
    $w.desc.text insert end [string trim $::tr(MyPlayerNamesDescription)]
    $w.desc.text configure -state disabled
    pack $w.desc -side top -fill x
    autoscrollframe $w.f text $w.f.text \
            -background white -width 50 -height 10 -wrap none
    foreach name $myPlayerNames {
        $w.f.text insert end "\n\"$name\""
    }
    pack $w.f -side top -fill both -expand yes
    button $w.b.white -text $::tr(White) -command {
        .editMyPlayerNames.f.text insert end "\"[sc_game info white]\"\n"
    }
    button $w.b.black -text $::tr(Black) -command {
        .editMyPlayerNames.f.text insert end "\"[sc_game info black]\"\n"
    }
    button $w.b.help -text $::tr(Help) \
            -command {helpWindow Options MyPlayerNames}
    button $w.b.ok -text OK -command editMyPlayerNamesOK
    button $w.b.cancel -text $::tr(Cancel) -command "grab release $w; destroy $w"
    pack $w.b.cancel $w.b.ok -side right -padx 5 -pady 5
    pack $w.b.white $w.b.black $w.b.help -side left -padx 5 -pady 5
    grab $w
}

proc editMyPlayerNamesOK {} {
    global myPlayerNames
    set w .editMyPlayerNames
    set text [string trim [$w.f.text get 1.0 end]]
    set myPlayerNames {}
    foreach name [split $text "\n"] {
        set name [string trim $name]
        if {[string match "\"*\"" $name]} {
            set name [string trim $name "\""]
        }
        if {$name != ""} { lappend myPlayerNames $name }
    }
    grab release $w
    destroy $w
}

# flipBoardForPlayerNames
#   Check if either player in the current game has a name that matches
#   a pattern in the specified list and if so, flip the board if
#   necessary to show from that players perspective.
#
proc flipBoardForPlayerNames {namelist {board .main.board}} {
    set white [sc_game info white]
    set black [sc_game info black]
    foreach pattern $namelist {
        if {[string match $pattern $white]} {
            ::board::flip $board 0
            return
        }
        if {[string match $pattern $black]} {
            ::board::flip $board 1
            return
        }
    }
}

# updateBoard:
#    Updates the main board. Also updates the navigation buttons, disabling
#    those that have no effect at this point in the game.
#    Also ensure all menu settings are up to date.
#    If a parameter "-pgn" is specified, the PGN text is also regenerated.
#    If a parameter "-animate" is specified, board changes are animated.
#
proc updateBoard {args} {
    set pgnNeedsUpdate 0
    set animate 0
    foreach arg $args {
        if {! [string compare $arg "-pgn"]} { set pgnNeedsUpdate 1 }
        if {! [string compare $arg "-animate"]} { set animate 1 }
    }

    if {$pgnNeedsUpdate} { ::pgn::Refresh $pgnNeedsUpdate }

    ::board::resize .main.board $::boardSize
    ::board::setmarks .main.board [sc_pos getComment]
    ::board::update .main.board [sc_pos board] $animate

    after cancel updateNavButtons
    after cancel ::notify::PosChanged

    update idletasks

    after idle updateNavButtons
    after idle ::notify::PosChanged
}

# updateNavButtons:
#    Update the status of each navigation button
#
proc updateNavButtons {} {
    global trialMode
    if {[sc_pos isAt start]} {
        .main.fbutton.button.start configure -state disabled
    } else { .main.fbutton.button.start configure -state normal }
    if {[sc_pos isAt end]} {
        .main.fbutton.button.end configure -state disabled
    } else { .main.fbutton.button.end configure -state normal }
    if {[sc_pos isAt vstart]} {
        .main.fbutton.button.back configure -state disabled
    } else { .main.fbutton.button.back configure -state normal }
    if {[sc_pos isAt vend]} {
        .main.fbutton.button.forward configure -state disabled
    } else { .main.fbutton.button.forward configure -state normal }
    # Cannot add a variation to an empty line:
    if {[sc_pos isAt vstart]  &&  [sc_pos isAt vend]} {
        .menu.edit entryconfig [tr EditAdd] -state disabled
        .main.fbutton.button.addVar configure -state disabled
        bind $::dot_w <Control-a> {}
    } else {
        .menu.edit entryconfig [tr EditAdd] -state normal
        .main.fbutton.button.addVar configure -state normal
        bind $::dot_w <Control-a> {sc_var create; updateBoard -pgn}
    }
    if {[sc_var count] == 0} {
        .main.fbutton.button.intoVar configure -state disabled
        .menu.edit entryconfig [tr EditDelete] -state disabled
        .menu.edit entryconfig [tr EditFirst] -state disabled
        .menu.edit entryconfig [tr EditMain] -state disabled
    } else {
        .main.fbutton.button.intoVar configure -state normal
        .menu.edit entryconfig [tr EditDelete] -state normal
        .menu.edit entryconfig [tr EditFirst] -state normal
        .menu.edit entryconfig [tr EditMain] -state normal
    }
    if {$trialMode} {
        .menu.edit entryconfig [tr EditUndo] -state disabled
        .menu.edit entryconfig [tr EditRedo] -state disabled
    } else {
        .menu.edit entryconfig [tr EditUndo] -state normal
        .menu.edit entryconfig [tr EditRedo] -state normal
    }
    updateVarMenus
    if {[sc_var level] == 0} {
        .main.fbutton.button.exitVar configure -state disabled
    } else {
        .main.fbutton.button.exitVar configure -state normal
    }

    wm withdraw .tooltip
    set comment [sc_pos getComment]
    # remove technical comments, notify only human readable ones
    regsub -all {\[%.*\]} $comment {} comment
    if {$comment != ""} {
         .main.fbutton.button.comment configure -image comment_avail -relief flat
         ::utils::tooltip::Set .main.fbutton.button.comment $comment
    } else {
         .main.fbutton.button.comment configure -image comment_unavail -relief flat
         ::utils::tooltip::UnSet .main.fbutton.button.comment
    }
   .main.fbutton.button.hgame_prev configure -state [::game::Hprev_btnstate]
   .main.fbutton.button.hgame_next configure -state [::game::Hnext_btnstate]
}

# updateGameInfo:
#    Update the game status window .main.gameInfo
#
proc updateGameInfo {} {
    global gameInfo

    .main.gameInfo configure -state normal
    .main.gameInfo delete 0.0 end
    ::htext::display .main.gameInfo [sc_game info -hide $gameInfo(hideNextMove) \
            -material $gameInfo(showMaterial) \
            -cfull $gameInfo(fullComment) \
            -fen $gameInfo(showFEN) -tb $gameInfo(showTB)]
    if {$gameInfo(wrap)} {
        .main.gameInfo configure -wrap word
        .main.gameInfo tag configure wrap -lmargin2 10
        .main.gameInfo tag add wrap 1.0 end
    } else {
        .main.gameInfo configure -wrap none
    }
    .main.gameInfo configure -state disabled
    updatePlayerPhotos
}

# Set up player photos:

image create photo photoW
image create photo photoB
label .main.photoW -background white -image photoW -anchor ne
label .main.photoB -background white -image photoB -anchor ne

# readPhotoFile executed once at startup for each SPF file. Loads SPI file if it exists.
# Otherwise it generates index information and tries to write SPI file to disk (if it can be done)
proc readPhotoFile {fname} {
    global photobegin
    global photosize
    global spffile
    set count 0
    set writespi 0
    
    if {! [regsub {\.spf$} $fname {.spi} spi]} {
        # How does it happend?
        return
    }
    
    # If SPI file was found then just source it and exit
    if { [file readable $spi]} {
        set count [array size spffile]
        source $spi
        set newcount [array size spffile]
        if {[expr $newcount - $count] > 0} {
            ::splash::add "Found [expr $newcount - $count] player photos in [file tail $fname]"
            ::splash::add "Loading information from index file [file tail $spi]"
            return
        }
    }
    
    # Check for the absence of the SPI file and check for the write permissions
    if { ![file exists $spi] && ![catch {open $spi w} fd_spi]} {
        # SPI file will be written to disk by scid
        set writespi 1
    }
    
    if {! [file readable $fname]} { return }
    
    set fd [open $fname]
    while {[gets $fd line] >= 0} {
        # search for the string      photo "Player Name"
        if { [regexp {^photo \"(.*)\" \{$} $line -> name] } {
            set count [expr $count + 1 ]
            set begin [tell $fd]
            # skip data block
            while {1} {
                set end [tell $fd]
                gets $fd line
                if {[regexp {.*\}.*} $line ]} {break}
            }
            set trimname [trimString $name]
            set size [expr $end - $begin ]
            set photobegin($trimname) $begin
            set photosize($trimname) $size
            set spffile($trimname) $fname
            if { $writespi } {
                # writing SPI file to disk
                puts $fd_spi "set \"photobegin($trimname)\" $begin"
                puts $fd_spi "set \"photosize($trimname)\" $size"
                puts $fd_spi "set \"spffile($trimname)\" \"\$fname\""
            }
        }
    }
    if {$count > 0 && $writespi} {
        ::splash::add "Found $count player photos in [file tail $fname]"
        ::splash::add "Index file [file tail $spi] was generated succesfully"
    }
    if {$count > 0 && !$writespi} {
        ::splash::add "Found $count player photos in [file tail $fname]"
        ::splash::add "Could not generate index file [file tail $spi]"
        ::splash::add "Use spf2spi script to generate [file tail $spi] file "
    }
    
    if { $writespi } { close $fd_spi }
    close $fd
}


#convert $data string tolower case and strip the first two blanks.
proc trimString {data} {
    set data [string tolower $data]
    set strindex [string first "\ " $data]
    set data [string replace $data $strindex $strindex]
    set strindex [string first "\ " $data]
    set data [string replace $data $strindex $strindex]
    return $data
}


# retrieve photo from the SPF file using index information
proc getphoto {name} {
    global photobegin
    global photosize
    global spffile
    set data ""
    if {[info exists spffile($name)]} {
        set fd [open $spffile($name)]
        seek $fd $photobegin($name) start
        set data [read $fd $photosize($name) ]
        close $fd
    }
    return $data
}

proc addPhotoAlias {aliasname name} {
    global photobegin
    global photosize
    global spffile
    global droppedaliases
    if {[info exists spffile([trimString $name])]} {
        set photobegin([trimString $aliasname]) $photobegin([trimString $name])
        set photosize([trimString $aliasname]) $photosize([trimString $name])
        set spffile([trimString $aliasname]) $spffile([trimString $name])
    } else {
        set droppedaliases [expr $droppedaliases + 1 ]
    }
}

# photobegin($name) - file offset of the photo for the player $name
# photobegin($name) - size (in bytes) of the photo for the player $name
# spffile($name) - location of the SPF file where photo for the player $name is stored
array set photobegin {}
array set photosize {}
array set spffile {}

# variable droppedaliases counts the number of the dropped aliases.
# Alias is dropped if the player hasn't photo.
set droppedaliases 0

# Directories where Scid searches for the photo files
set photodirs [list $scidDataDir $scidUserDir $scidConfigDir [file join $scidShareDir "photos"]]

# Read all Scid photo (*.spf) files in the Scid data/user/config directories:
foreach dir $photodirs {
    foreach photofile [glob -nocomplain -directory $dir "*.spf"] {
        readPhotoFile $photofile
    }
}

# Read all Scid photo aliases (*.spa)
foreach dir $photodirs {
    foreach spa [glob -nocomplain -directory $dir "*.spa"] {
        if {! [file readable $spa]} { return }
        set count [array size spffile]
        set droppedcount $droppedaliases
        source $spa
        set newcount [array size spffile]
        set newdroppedcount $droppedaliases
        if {[expr $newcount - $count] > 0} {
            ::splash::add "Found [expr $newcount - $count] player aliases in [file tail $spa]"
        }
        if {[expr $newdroppedcount - $droppedcount] > 0} {
            ::splash::add "Dropped [expr $newdroppedcount - $droppedcount] player aliases in [file tail $spa]"
        }
    }
}


set photo(oldWhite) {}
set photo(oldBlack) {}

# Try to change the engine name: ignore version number, try to ignore blanks
proc trimEngineName { engine } {
    global spffile
    set engine [sc_name retrievename $engine]
    
    set engine [string tolower $engine]
    
    if { [string first "deep " $engine] == 0 } {
        # strip "deep "
        set engine [string range $engine 5 end]
    }
    # delete two first blank to make "The King" same as "TheKing"
    # or "Green Light Chess" as "Greenlightchess"
    set strindex [string first "\ " $engine]
    set engine [string replace $engine $strindex $strindex]
    set strindex [string first "\ " $engine]
    set engine [string replace $engine $strindex $strindex]
    set strindex [string first "," $engine]
    set slen [string len $engine]
    if { $strindex == -1 && $slen > 2 } {
        #seems to be a engine name:
        # search until longest name matches an engine name
        set slen [string len $engine]
        for { set strindex $slen} {![info exists spffile([string range $engine 0 $strindex])]\
                    && $strindex > 2 } {set strindex [expr {$strindex - 1}] } { }
        set engine [string range $engine 0 $strindex]
    }
    return $engine
}

# updatePlayerPhotos
#   Updates the player photos in the game information area
#   for the two players of the current game.
#
proc updatePlayerPhotos {{force ""}} {
    global photo
    global spffile
    if {$force == "-force"} {
        # Force update even if it seems unnecessary. This is done
        # when the user selects to show or hide the photos.
        set photo(oldWhite) {}
        set photo(oldBlack) {}
        place forget .main.photoW
        place forget .main.photoB
    }
    if {! $::gameInfo(photos)} { return }
    #get photo from player
    set white [sc_game info white]
    set black [sc_game info black]
    
    catch { set white [trimEngineName $white] }
    catch { set black [trimEngineName $black] }
    
    if {$black != $photo(oldBlack)} {
        set photo(oldBlack) $black
        place forget .main.photoB
        if {[info exists spffile($black)]} {
            image create photo photoB -data [getphoto $black ]
            .main.photoB configure -image photoB -anchor ne
            place .main.photoB -in .main.gameInfo -x -1 -relx 1.0 -anchor ne
            # force to update white, black size could be changed
            set photo(oldWhite) {}
        }
    }
    set distance [expr {[image width photoB] + 2}]
    if { $distance < 10 } { set distance 82 }
    if {$white != $photo(oldWhite)} {
        set photo(oldWhite) $white
        place forget .main.photoW
        if {[info exists spffile($white)]} {
            image create photo photoW -data [getphoto $white ]
            .main.photoW configure -image photoW -anchor ne
            place .main.photoW -in .main.gameInfo -x -$distance -relx 1.0 -anchor ne
        }
    }
    bind .main.photoW <ButtonPress-1> "togglePhotosSize"
    bind .main.photoB <ButtonPress-1> "togglePhotosSize"
    set ::photosMinimized 0
}
################################################################################
# Toggles photo sizes
################################################################################
set photosMinimized 0
proc togglePhotosSize {} {
    set distance [expr {[image width photoB] + 2}]
    if { $distance < 10 } { set distance 82 }
    
    if {$::photosMinimized} {
        set ::photosMinimized 0
        if { [winfo ismapped .main.photoW] } {
            place .main.photoW -in .main.gameInfo -x -$distance -relx 1.0 -relheight 1 -width [image width photoW] -anchor ne
        }
        if { [winfo ismapped .main.photoB] } {
            place .main.photoB -in .main.gameInfo -x -1 -relx 1.0 -relheight 1 -width [image width photoB] -anchor ne
        }
    } else  {
        set ::photosMinimized 1
        if { [winfo ismapped .main.photoW] } {
            place .main.photoW -in .main.gameInfo -x -17 -relx 1.0 -relheight 0.15 -width 15 -anchor ne
        }
        if { [winfo ismapped .main.photoB] } {
            place .main.photoB -in .main.gameInfo -x -1 -relx 1.0  -relheight 0.15 -width 15 -anchor ne
        }
    }
    
}
#########################################################
### Chess move input

# Globals for mouse-based move input:

set selectedSq -1
set bestSq -1

set EMPTY 0
set KING 1
set QUEEN 2
set ROOK 3
set BISHOP 4
set KNIGHT 5
set PAWN 6

################################################################################
#
################################################################################
proc getPromoPiece {} {
    set w .promoWin
    set ::result 2
    toplevel $w
    # wm transient $w .main
    ::setTitle $w "Scid"
    wm resizable $w 0 0
    set col "w"
    if { [sc_pos side] == "black" } { set col "b" }
    ttk::button $w.bq -image ${col}q45 -command "set ::result 2 ; destroy $w"
    ttk::button $w.br -image ${col}r45 -command "set ::result 3 ; destroy $w"
    ttk::button $w.bb -image ${col}b45 -command "set ::result 4 ; destroy $w"
    ttk::button $w.bn -image ${col}n45 -command "set ::result 5 ; destroy $w"
    pack $w.bq $w.br $w.bb $w.bn -side left
    bind $w <Escape> "set ::result 2 ; destroy $w"
    bind $w <Return> "set ::result 2 ; destroy $w"
    update
    catch { grab $w }
    tkwait window $w
    return $::result
}

# confirmReplaceMove:
#   Asks the user what to do when adding a move when a move already
#   exists.
#   Returns a string value:
#      "replace" to replace the move, truncating the game.
#      "var" to add the move as a new variation.
#      "cancel" to do nothing.
#
set addVariationWithoutAsking 0

proc confirmReplaceMove {} {
    global askToReplaceMoves trialMode
    
    # If reviewing a game, enter a var automatically
    if {[winfo exists $::reviewgame::window]} {
        return "var"
    }
    
    if {$::addVariationWithoutAsking} { return "var" }
    
    if {! $askToReplaceMoves} { return "replace" }
    if {$trialMode} { return "replace" }
    
    option add *Dialog.msg.wrapLength 4i interactive
    catch {tk_dialog .dialog "Scid: $::tr(ReplaceMove)?" \
                $::tr(ReplaceMoveMessage) "" 0 \
                $::tr(ReplaceMove) $::tr(NewMainLine) \
                $::tr(AddNewVar) [tr EditTrial] \
                $::tr(Cancel)} answer
    option add *Dialog.msg.wrapLength 3i interactive
    if {$answer == 0} { return "replace" }
    if {$answer == 1} { return "mainline" }
    if {$answer == 2} { return "var" }
    if {$answer == 3} { setTrialMode 1; return "replace" }
    return "cancel"
}

proc addNullMove {} {
    addMove null null
}

# addMove:
#   Adds the move indicated by sq1 and sq2 if it is legal. If the move
#   is a promotion, getPromoPiece will be called to get the promotion
#   piece from the user.
#   If the optional parameter is "-animate", the move will be animated.
#
proc addMove { sq1 sq2 {animate ""}} {
    if { [::fics::setPremove $sq1 $sq2] || ! [::fics::playerCanMove] || ! [::reviewgame::playerCanMove]} { return } ;# not player's turn
    
    global EMPTY
    set nullmove 0
    if {$sq1 == "null"  &&  $sq2 == "null"} { set nullmove 1 }
    if {!$nullmove  &&  [sc_pos isLegal $sq1 $sq2] == 0} {
        # Illegal move, but if it is King takes king then treat it as
        # entering a null move:
        set board [sc_pos board]
        set k1 [string tolower [string index $board $sq1]]
        set k2 [string tolower [string index $board $sq2]]
        if {$k1 == "k"  &&  $k2 == "k"} { set nullmove 1 } else { return }
    }
    set promo $EMPTY
    if {[sc_pos isPromotion $sq1 $sq2] == 1} {
        # sometimes, addMove is triggered twice
        if { [winfo exists .promoWin] } { return }
        set promo [getPromoPiece]
    }
    
    set promoLetter ""
    switch -- $promo {
        2 { set promoLetter "q"}
        3 { set promoLetter "r"}
        4 { set promoLetter "b"}
        5 { set promoLetter "n"}
        default {set promoLetter ""}
    }
    
    # Autmatically follow the main line if the next move is the same or enter the relevant variation if it exists
    if {! $::annotateMode} {
        set moveUCI [::board::san $sq2][::board::san $sq1]$promoLetter
        set move [sc_game info nextMoveUCI]
        if { [ string compare -nocase $moveUCI $move] == 0 } {
            sc_move forward
            updateBoard
            return
        }
        set varList [sc_var list UCI]
        set i 0
        foreach { move } $varList {
            if { [ string compare -nocase $moveUCI $move] == 0 } {
                sc_var moveInto $i
                updateBoard
                return
            }
            incr i
        }
    }
    
    undoFeature save
    
    set action "replace"
    if {![sc_pos isAt vend]} {
        set action [confirmReplaceMove]
    }
    if {$action == "replace"} {
        # nothing
    } elseif {$action == "mainline" || $action == "var"} {
        if {[winfo exists .commentWin]} {
            ::commenteditor::storeComment
            .commentWin.cf.text delete 0.0 end
        }
        sc_var create
    } else {
        # Do not add the move at all:
        return
    }
    
    if {$nullmove} {
        sc_move addSan null
    } else {
        set ::sergame::lastPlayerMoveUci ""
        if {[winfo exists ".serGameWin"]} {
            set ::sergame::lastPlayerMoveUci "[::board::san $sq2][::board::san $sq1]$promoLetter"
        }
        sc_move add $sq1 $sq2 $promo
        set san [sc_game info previous]
        if {$action == "mainline"} {
            sc_var exit
            sc_var promote [expr {[sc_var count] - 1}]
            sc_move forward 1
        }
        after idle [list ::utils::sound::AnnounceNewMove $san]
        
        if {[winfo exists .commentWin]} { .commentWin.cf.text delete 0.0 end }
    }
    
    if {[winfo exists .fics]} {
        
        if { [::fics::playerCanMove] } {
            if { $promo != $EMPTY } {
                ::fics::writechan "promote $promoLetter"
            }
            ::fics::writechan [ string range [sc_game info previousMoveUCI] 0 3 ]
        }
    }
    
    if {$::novag::connected} {
        ::novag::addMove "[::board::san $sq2][::board::san $sq1]$promoLetter"
    }
    
    moveEntry_Clear
    updateBoard -pgn $animate
    
    ::tree::doTraining
    
}

# addSanMove
#   Like addMove above, but takes the move in SAN notation instead of
#   a pair of squares.
#
proc addSanMove {san {animate ""} {noTraining ""}} {
    
    if {! $::annotateMode} {
        set move [sc_game info nextMoveNT]
        if { [ string compare -nocase $san $move] == 0 } {
            sc_move forward
            updateBoard
            return
        }
        set varList [sc_var list]
        set i 0
        foreach { move } $varList {
            if { [ string compare -nocase $san $move] == 0 } {
                sc_var moveInto $i
                updateBoard
                return
            }
            incr i
        }
    }
    
    set action "replace"
    if {![sc_pos isAt vend]} {
        set action [confirmReplaceMove]
    }
    if {$action == "replace"} {
        # nothing
    } elseif {$action == "var" || $action == "mainline"} {
        sc_var create
    } else {
        # Do not add the move at all:
        return
    }
    # if {[winfo exists .commentWin]} { .commentWin.cf.text delete 0.0 end }
    undoFeature save
    sc_move addSan $san
    if {$action == "mainline"} {
        sc_var exit
        sc_var promote [expr {[sc_var count] - 1}]
    }
    moveEntry_Clear
    updateBoard -pgn $animate
    ::utils::sound::AnnounceNewMove $san
    if {$noTraining != "-notraining"} {
        ::tree::doTraining
    }
}

# enterSquare:
#   Called when the mouse pointer enters a board square.
#   Finds the best matching square for a move (if there is a
#   legal move to or from this square), and colors the squares
#   to indicate the suggested move.
#
proc enterSquare { square } {	
    global bestSq bestcolor selectedSq suggestMoves
    if {$selectedSq == -1} {
        set bestSq -1
        if {$suggestMoves && [expr {abs($::fics::playing) != 1}]} {
            set bestSq [sc_pos bestSquare $square]
            if {$bestSq != -1} {
                ::board::colorSquare .main.board $square $bestcolor
                ::board::colorSquare .main.board $bestSq $bestcolor        
            }
        }
    }
}

# leaveSquare:
#    Called when the mouse pointer leaves a board square.
#    Recolors squares to normal (lite/dark) color.
#
proc leaveSquare { square } {
    global selectedSq bestSq
    if {$selectedSq == -1} {
        ::board::colorSquare .main.board $bestSq
        ::board::colorSquare .main.board $square  
    }
}

# pressSquare:
#    Called when the left mouse button is pressed on a square. Sets
#    that square to be the selected square.
#
proc pressSquare { square } {
    global selectedSq highcolor
    
    if { ![::fics::playerCanMove] || ![::reviewgame::playerCanMove] } { return } ;# not player's turn
    
    # if training with calculations of var is on, just log the event
    if { [winfo exists .calvarWin] } {
        ::calvar::pressSquare $square
        return
    }
    
    if {$selectedSq == -1} {
        set selectedSq $square
        ::board::colorSquare .main.board $square $highcolor
        # Drag this piece if it is the same color as the side to move:
        set c [string index [sc_pos side] 0]  ;# will be "w" or "b"
        set p [string index [::board::piece .main.board $square] 0] ;# "w", "b" or "e"
        if {$c == $p} {
            ::board::setDragSquare .main.board $square
        }
    } else {
        ::board::setDragSquare .main.board -1
        ::board::colorSquare .main.board $selectedSq
        ::board::colorSquare .main.board $square
        if {$square != $selectedSq} {
            addMove $square $selectedSq -animate
        }
        set selectedSq -1
        enterSquare $square
    }
}

# releaseSquare:
#   Called when the left mouse button is released over a square.
#   If the square is different to that the button was pressed on, it
#   is a dragged move; otherwise it is just selecting this square as
#   part of a move.
#
proc releaseSquare { w x y } {
    
    if { [winfo exists .calvarWin] } { return }
    
    global selectedSq bestSq
    
    ::board::setDragSquare $w -1
    set square [::board::getSquare $w $x $y]
    if {$square < 0} {
        set selectedSq -1
        return
    }
    
    if {$square == $selectedSq} {
        if {$::suggestMoves} {
            # User pressed and released on same square, so make the
            # suggested move if there is one:
            set selectedSq -1
            ::board::colorSquare $w $bestSq
            ::board::colorSquare $w $square
            addMove $square $bestSq -animate
            enterSquare $square
        } else {
            # Current square is the square user pressed the button on,
            # so we do nothing.
        }
    } else {
        # User has dragged to another square, so try to add this as a move:
        addMove $square $selectedSq
        ::board::colorSquare $w $selectedSq
        set selectedSq -1
        ::board::colorSquare $w $square
    }
}


# backSquare:
#    Handles the retracting of a move (when the right mouse button is
#    clicked on a square). Recolors squares to normal color also.
#    If the move is the last in the game or variation, is is removed
#    by truncating the game after retracting the move.
#
proc backSquare {} {
    global selectedSq bestSq
    set lastMoveInLine 0
    if {[sc_pos isAt vend]} {
        set lastMoveInLine 1
    }
    sc_move back
    
    # RMB used to delete the move if it was the last in a line. Removed it as there is no undo.
    # if {[sc_pos isAt vstart] && [sc_var level] != 0} {
    # ::pgn::deleteVar [sc_var number]
    # } elseif {$lastMoveInLine} {
    # sc_game truncate
    # }
    
    set selectedSq -1
    set bestSq -1
    # update the board without -pgn option because of poor performance with long games
    updateBoard -animate
    ::utils::sound::AnnounceBack
}


##
## Auto-playing of moves:
##
set autoplayMode 0

set tempdelay 0
trace variable tempdelay w {::utils::validate::Regexp {^[0-9]*\.?[0-9]*$}}
# ################################################################################
# Set the delay between moves in options menu
################################################################################
proc setAutoplayDelay {} {
    global autoplayDelay tempdelay
    set tempdelay [expr {$autoplayDelay / 1000.0}]
    set w .apdialog
    if { [winfo exists $w] } { focus $w ; return }
    toplevel $w
    ::setTitle $w "Scid"
    wm resizable $w 0 0
    ttk::label $w.label -text $::tr(AnnotateTime:)
    pack $w.label -side top -pady 5 -padx 5
    spinbox $w.spDelay -background white -width 4 -textvariable tempdelay -from 1 -to 300 -increment 1
    pack $w.spDelay -side top -pady 5
    
    set b [ttk::frame $w.buttons]
    pack $b -side top -fill x
    ttk::button $b.cancel -text $::tr(Cancel) -command {
        destroy .apdialog
        focus .
    }
    ttk::button $b.ok -text "OK" -command {
        if {$tempdelay < 0.1} { set tempdelay 0.1 }
        set autoplayDelay [expr {int($tempdelay * 1000)}]
        destroy .apdialog
        focus .
    }
    pack $b.cancel $b.ok -side right -padx 5 -pady 5
    bind $w <Escape> { .apdialog.buttons.cancel invoke }
    bind $w <Return> { .apdialog.buttons.ok invoke }
    focus $w.spDelay
}
################################################################################
#
################################################################################
proc toggleAutoplay { } {
    global autoplayMode autoplayDelay
    if {$autoplayMode == 0} {
        set autoplayMode 1
        # Change the autoplay icon in the main window
        #
        .main.fbutton.button.autoplay configure -image autoplay_on -relief sunken
        # Start with some delay
        # Only to spawn the autoplay on a new thread
        #
        after 500 autoplay
    } else {
        cancelAutoplay
    }
}

################################################################################
#
################################################################################
proc autoplay {} {
    global autoplayDelay autoplayMode annotateMode analysis
    
    # Was autoplay stopped by the user since the last time the timer ran out?
    # If so, silently exit this handler
    #
    if { $autoplayMode == 0 } {
        return
    }
    
    # Add annotation if needed
    #
    if { $annotateMode } {
        addAnnotation
    }
    
    if { $::initialAnalysis } {
        # Stop analyis if it is running
        # We do not want initial super-accuracy
        #
        stopEngineAnalysis 1
        set annotateMode 1
        # First do the book analysis (if this is configured)
        # The latter condition is handled by the operation itself
        set ::wentOutOfBook 0
        bookAnnotation 1
        # Start the engine
        startEngineAnalysis 1 1
    
    # Autoplay comes in two flavours:
    # + It can run through a game, with or witout annotation
    # + It can be annotating just opening sections of games
    # See if such streak ends here and now
    #
    } elseif { [sc_pos isAt end] || ($annotateMode && $::isBatchOpening && ([sc_pos moveNumber] > $::isBatchOpeningMoves)) } {
        
        # Stop the engine
        #
        stopEngineAnalysis 1
        
        # Are we running a batch analysis?
        #
        if { $annotateMode && $::isBatch } {
            # First replace the game we just finished
            #
            set gameNo [sc_game number]
            if { $gameNo != 0 } {
                sc_game save $gameNo
            }
            
            # See if we must advance to the next game
            #
            if { $gameNo < $::batchEnd } {
                incr gameNo
                sc_game load $gameNo
                updateMenuStates
                updateStatusBar
                updateTitle
                updateBoard -pgn
                # First do book analysis
                #
                set ::wentOutOfBook 0
                bookAnnotation 1
                # Start with initial assessment of the position
                #
                set ::initialAnalysis 1
                # Start the engine
                #
                startEngineAnalysis 1 1
            } else {
                # End of batch, stop
                #
                cancelAutoplay
                return
            }
        } else {
            # Not in a batch, just stop
            #
            cancelAutoplay
            return
        }
    } elseif { $annotateMode && $::isAnnotateVar } {
        # A construction to prune empty variations here and now
        # It makes no sense to discover only after some engine
        # time that we entered a dead end.
        #
        set emptyVar 1
        while { $emptyVar } {
            set emptyVar 0
            # Are we at the end of a variation?
            # If so, pop back into the parent
            #
            if { [sc_pos isAt vend] } {
                sc_var exit
                set lastVar [::popAnalysisData]
            } else {
                set lastVar [sc_var count]
            }
            # Is there a subvariation here?
            # If so, enter it after pushing where we are
            #
            if { $lastVar > 0 } {
                incr lastVar -1
                sc_var enter $lastVar
                ::pushAnalysisData $lastVar
                # Check if this line is empty
                # If so, we will pop back immediately in the next run
                #
                if { [sc_pos isAt vstart] && [sc_pos isAt vend] } {
                    set emptyVar 1
                } else {
                    # We are in a new line!
                    # Tell the annotator (he might be interested)
                    #
                    updateBoard -pgn
                    set ::atStartOfLine 1
                }
            } else {
                # Just move ahead following the current line
                #
                ::move::Forward
            }
        }
    } else {
        # Just move ahead following the main line
        #
        ::move::Forward
    }
    
    # Respawn
    #
    after $autoplayDelay autoplay
}
################################################################################
#
################################################################################
proc cancelAutoplay {} {
    global autoplayMode annotateMode annotateModeButtonValue
    set autoplayMode 0
    set annotateMode 0
    set annotateModeButtonValue 0
    after cancel autoplay
    .main.fbutton.button.autoplay configure -image autoplay_off -relief flat
}
################################################################################
#
################################################################################

bind $dot_w <Return> {
    if {[winfo exists .analysisWin1] && $analysis(analyzeMode1)} {
        .analysisWin1.b1.move invoke
    }
}

bind $dot_w <Escape> cancelAutoplay

set trialMode 0

proc setTrialMode {mode} {
    global trialMode
    if {$mode == "toggle"} {
        set mode [expr {1 - $trialMode}]
    }
    if {$mode == $trialMode} { return }
    if {$mode == "update"} { set mode $trialMode }
    
    if {$mode == 1} {
        set trialMode 1
        sc_game push copy
        .main.fbutton.button.trial configure -image tb_trial_on
    } else {
        set trialMode 0
        sc_game pop
        .main.fbutton.button.trial configure -image tb_trial
    }
    updateBoard -pgn
}

proc undoFeature {action} {
    global trialMode
    if {! $trialMode} {
        if {$action == "save"} {
            sc_game undoPoint
        } elseif {$action == "undo"} {
            sc_game undo
            updateBoard -pgn
        } elseif {$action == "redo"} {
            sc_game redo
            updateBoard -pgn
        }
    }
}

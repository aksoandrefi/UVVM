# Compile Bitvis Util
#----------------------------------

# This file may be called with an argument
# arg 1: Part directory of this library/module

# Overload quietly (Modelsim specific command) to let it work in Riviera-Pro
proc quietly { args } {
  if {[llength $args] == 0} {
    puts "quietly"
  } else {
    # this works since tcl prompt only prints the last command given. list prints "".
    uplevel $args; list;
  }
}

if {[batch_mode]} {
  onerror {abort all; exit -f -code 1}
} else {
  onerror {abort all}
}
#Just in case...
quietly quit -sim   

# Set up util_part_path 
#------------------------------------------------------
quietly set part_name "uvvm_util"
# path from mpf-file in sim
quietly set util_part_path "../..//$part_name"

if { [info exists 1] } {
  # path from this part to target part
  quietly set util_part_path "$1/..//$part_name"
  unset 1
}

do $util_part_path/script/compile_src.do $util_part_path

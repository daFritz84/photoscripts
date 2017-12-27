# !/bin/bash
#
# move all file endings from upper case to lower case
#
rename 's/\.([^.]+)$/.\L$1/' *

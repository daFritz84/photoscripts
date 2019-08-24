# !/bin/bash
# rename all images according to their exif date with ascending numbers.
#
#
# array of considered filetypes
#
FILETYPES=("*.jpg *.JPG");
#
#
###############################################################################
# Check prerequisites
I=`which exiftool`
if [ "$I" == "" ]; then
  echo "The 'exiftool' command is missing or not available."
  exit 1
fi;
###############################################################################
# Scanning loop
for file in $FILETYPES; do
    date_str="$(
        exiftool -d %Y%m%d_%H%M%S "$file" |
        awk -F': ' '/Create Date/{print $2; exit}'
        )"

    # for some reason, the file has no creation date -> fail with error
    if [ "$date_str" == "" ]; then
      echo "no creation date found in $file"
      exit 1
    fi;

    filetype="$(echo "$file"|awk -F . '{print $NF}')"
    echo "renaming $file to $date_str.$filetype"

    mv "$file" "$date_str.$filetype"
done;

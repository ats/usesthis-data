#!/bin/bash

# -- build-data.sh:

# Do a bunch of parsing to generate tab-separated thesetup-data.txt file
# Assumes that the usesthis-data directory shares a parent directory with the
# usesthis repo

# get all the [description][item] references from the _posts directory
grep -oEH '\[([^\[\(\)]+)\]\[([a-z0-9\.\-]+)?\]' ../usesthis/_posts/*.interview > gear-raw.txt

# clean out path
perl -p -i -e 's/.*\/_posts\///g' gear-raw.txt
# clean up user name
perl -p -i -e 's/.interview:\[/:[/g' gear-raw.txt
# start making record separators
perl -p -i -e 's/^\[/:[/g' gear-raw.txt
perl -p -i -e 's/^([0-9\-]+)\-([a-z)])/$1\t$2/' gear-raw.txt
awk ' {
  if (/^[0-9a-z.]+/) {
	print $0
    gsub(/:.*/, "")
    name = $0
  }
  if (/^:\[/){
	print name $0
  }
}' gear-raw.txt > gear-names.txt

# more record separators
awk '{
	gsub(/:\[/, "\t")
	gsub(/\]\[/, "\t")
	gsub(/\]/, "")
	print
}' gear-names.txt > gear-parsed.txt

# complete tab delimiting
# set usesthis column to lowercase
awk 'BEGIN {
	FS = "\t"
	OFS = "\t"
	};	
	{ if ($4 == "") { $4 = $3 }
	print $1, $2, $3, tolower($4)
}' gear-parsed.txt > gear-delimited.txt

# break out date into yyyy \t mm \t dd for later use
awk 'BEGIN { FS= "\t"; OFS = "\t" } { gsub(/\-/, "\t", $1); print } ' gear-delimited.txt > thesetup-data.txt

# # add header row
# awk '{
#   	if (NR==0) { print "date\tname\tgear\tusesthis" }
# 	else { print $0 }
# }' gear-delimited.txt > thesetup-data.txt

# rm temp files
rm gear-names.txt
rm gear-parsed.txt
rm gear-raw.txt
rm gear-delimited.txt

# data is now in thesetup-data.txt

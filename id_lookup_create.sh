#!/bin/bash
# id_lookup_create.sh
# create id_lookup.txt file
# contact: allynstott@gmail.com

xmlfile="$1"

# print help
if [ $# -eq 0 ]; then
	echo "$0 U_RedHat_6_VX_Manual-xccdf.xml"
	exit 1
fi

# parse for vuln ids and rule ids
output="`grep '<Group\|<Rule id' $xmlfile | cut -d'"' -f2`"
vulnids="`echo -e "$output" | awk 'NR%2 != 0'`"
ruleids="`echo -e "$output" | awk 'NR%2 != 1'`"

# combine vulnids with rulesids with ":" delimiter
paste -d ':' <(echo "$vulnids") <(echo -e "$ruleids")

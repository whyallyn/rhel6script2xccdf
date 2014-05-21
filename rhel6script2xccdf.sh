#!/bin/bash
# rhel6script2xccdf.sh
# put rhel6 script output into xccdf results format
# tested on RHEL6_STIG_Check_Script_v1.0.2
# contact: allynstott@outlook.com

inputfile="$1"
outputfile="$inputfile.xml"
ruletranslatefile="`dirname \"$0\"`/id_lookup.txt"

# print help
if [ $# -eq 0 ]; then
	echo "$0 RHEL6_Script_Output.txt [id_lookup.txt]"
	exit 1
fi

# set rule translate file
if [ $# -eq 2 ]; then
	ruletranslatefile="$2"
elif [  ! -e $ruletranslatefile ]; then
	echo "ERROR: id_lookup.txt does not exist! Create the file using id_lookup_create.sh"
	exit 1
fi

# put script output into format $result:$vulnid
output=`cat $inputfile | grep '^0\|^1' | cut -d':' -f1 | sed 's/-C[1-3]-/:V-/g' | sed 's/0-38489/0:V-38489/g' | sed 's/1-38489/1:V-38489/g' | sed 's/^0/pass/g' | sed 's/^1/fail/g'`

# put output into format $result:$ruleid
foutput=""
for line in $output; do
	result=`echo $line | cut -d':' -f1`
	vulnid=`echo $line | cut -d':' -f2`

	# lookup vulnid for ruleid
	ruleid=`grep "$vulnid" "$ruletranslatefile" | cut -d':' -f2`

	foutput=`echo -e "$foutput\n$result:$ruleid"`
done

# write xccdf header
echo '<?xml version="1.0" encoding="UTF-8"?>' > $outputfile
echo '<TAG_1 resolved="1" xsi:schemaLocation="empty" xmlns:cdf="empty" xmlns:cpe="empty" xmlns:xsi="empty" xmlns:dsig="empty" xmlns:dc="empty" xmlns:xhtml="empty">' >> $outputfile

# write results in xccdf format
for line in $foutput; do
	result=`echo "$line" | cut -d':' -f1`
	ruleid=`echo "$line" | cut -d':' -f2`
	echo '<cdf:rule-result version="NA" time="NA" idref="'$ruleid'" weight="NA" severity="NA"><cdf:result>'$result'</cdf:result>' >> $outputfile
	echo '</cdf:rule-result>' >> $outputfile
done

# write xccdf footer
echo '</TAG_1>' >> $outputfile

# complete
echo "Finished. See XCCDF results: $outputfile"

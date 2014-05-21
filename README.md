About
=====
This project is made up of the following:
* rhel6script2xccdf.sh: converts results from rhel6_stig_script into XCCDF XML results to be imported into the DISA STIG Viewer
* id_lookup.txt: a table that maps VUL IDs to RULE IDs
* id_lookup_create.sh: creates the id_lookup.txt file when passed the RHEL6 Manual STIG XCCDF XML file
* samples/RHEL6_rhel6serverd_Complete_Scan_20140520.1445.txt: sample results from the rhel6_stig_script
* samples/RHEL6_rhel6serverd_Complete_Scan_20140520.1445.txt.xml: sample results from the rhel6_stig_script converted into a XCCDF XML using rhel6script2xccdf.sh


Usage
=====
1. Download RHEL6_STIG_Script from https://software.forge.mil/sf/projects/rhel6_stig_script
2. Download rhel6script2xccdf from https://github.com/allynstott/rhel6script2xccdf
3. Following the directions from the rhel6_stig_script project, run RHEL6_STIG_Check_Script_vX.X.X.sh to produce a results (.txt) file
4. Run rhel6script2xccdf.sh, passing the results (.txt) file as the first parameter
5. Using the DISA STIG Viewer, create a checklist from the RHEL6 Manual STIG XCCDF XML file
6. Import the XCCDF XML results created by rhel6script2xccdf.sh into the checklist
7. Be glad you didn’t have to do any of that manually!

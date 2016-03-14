#! /bin/bash
cd /c/Users/toolsadmin/Documents/Github/githubreports
ssh -p 122 admin@github-isl-01.ca.com "ghe-org-admin-promote -u toolsadmin"
rc=$?; if [[ $rc != 0 ]]; then exit $rc+1000; fi
now="$(date +'%Y_%m_%d_%H_%M_%S')"
ruby attestation_by_owner.rb 368ee15880d5012836d2f4282f66d62f6c7d260c > /c/Users/toolsadmin/Documents/CSCR/githubreports/attestation_$now.tsv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+2000; fi

#find "/c/Users/toolsadmin/Downloads" -name "all-*.csv" -exec rm {} \;
#"/c/Program Files (x86)/Mozilla Firefox/firefox.exe" -P "toolsadmin" -url https://github-isl-01.ca.com/stafftools/reports/all_users.js &
#sleep 10
#output=`ps -ef | grep firefox`
#set -- $output
#pid=$2
#kill $pid
#"/c/Program Files (x86)/Mozilla Firefox/firefox.exe" -P "toolsadmin" -url https://github-isl-01.ca.com/stafftools/reports/all_organizations.js &
#sleep 10
#output=`ps -ef | grep firefox`
#set -- $output
#pid=$2
#kill $pid
#"/c/Program Files (x86)/Mozilla Firefox/firefox.exe" -P "tooolsadmin" -url https://github-isl-01.ca.com/stafftools/reports/all_repositories.js &
#sleep 10
#output=`ps -ef | grep firefox`
#set -- $output
#pid=$2
#kill $pid
#
#cp /c/Users/toolsadmin/Downloads/all-*.csv /c/Users/faudo01/Documents/Github/DevelopmentAccess/githubreports/

#cd /c/Users/faudo01/Documents/CSCR
#sftp -b /c/Users/faudo01/Documents/CSCR/githubreport_sftp1.txt -oPort=122 admin@github-isl-01.ca.com
#ssh -p 122 admin@github-isl-01.ca.com "bash /tmp/ca-custom-all-users.sh" 
#sftp -b /c/Users/faudo01/Documents/CSCR/githubreport_sftp2.txt -oPort=122 admin@github-isl-01.ca.com
#ssh -p 122 admin@github-isl-01.ca.com "sudo rm /tmp/*.csv" 

cd /c/Users/toolsadmin/Documents/CSCR/githubreports
curl -u "toolsadmin:368ee15880d5012836d2f4282f66d62f6c7d260c" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+3000; fi
curl -u "toolsadmin:368ee15880d5012836d2f4282f66d62f6c7d260c" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+4000; fi
curl -u "toolsadmin:368ee15880d5012836d2f4282f66d62f6c7d260c" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+5000; fi

exit 0

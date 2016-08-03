#! /bin/bash

cd /c/Users/toolsadmin/Documents/Github/githubreports
ssh -i /c/Users/toolsadmin/.ssh/id_rsa -p 122 admin@github-isl-01.ca.com "ghe-org-admin-promote -u toolsadmin"
rc=$?; if [[ $rc != 0 ]]; then exit $rc+1000; fi
now="$(date +'%Y_%m_%d_%H_%M_%S')"
ruby attestation_by_owner.rb $1 > /c/Users/toolsadmin/Documents/CSCR/githubreports/attestation_$now.tsv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+2000; fi
ruby governance_by_owner.rb $1 > /c/Users/toolsadmin/Documents/CSCR/githubreports/governance_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+3000; fi


# Note: because the initial curl call can result in an indirection, the curl calls are run multiple times
cd /c/Users/toolsadmin/Documents/CSCR/githubreports
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+4000; fi
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
sleep 10
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_organizations.csv > all_organizations_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+5000; fi
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 40
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 40
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 40
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 40
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 40
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 40
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+6000; fi

exit 0

#! /bin/bash

cd /c/AutoSys/Github/githubreports
ssh -i /c/Users/toolsadmin/.ssh/id_rsa -p 122 admin@github-isl-01.ca.com "ghe-org-admin-promote -u toolsadmin"
rc=$?; if [[ $rc != 0 ]]; then exit $rc+1000; fi
now="$(date +'%Y_%m_%d_%H_%M_%S')"
ruby attestation_by_owner.rb $1 > /c/AutoSys/CSCR/githubreports/attestation_$now.tsv
rc=$?; if [[ $rc != 0 ]]; then exit $rc+2000; fi
#ruby governance_by_owner.rb $1 > /c/AutoSys/CSCR/githubreports/governance_$now.csv
#rc=$?; if [[ $rc != 0 ]]; then exit $rc+3000; fi


# Note: because the initial curl call can result in an indirection, the curl calls are run multiple times
cd /c/AutoSys/CSCR/githubreports
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

cd /c/AutoSys/CSCR
export JAVA_HOME=$JAVA_HOME_SCM_8
export PATH=$JAVA_HOME/bin:/c/AutoSys/CSCR/scmx86:$PATH
java -Xmx1024m -jar githubrepldap.jar -repofile /c/AutoSys/CSCR/githubreports/attestation_$now.tsv -orgfile /c/AutoSys/CSCR/githubreports/all_organizations_$now.csv -userfile /c/AutoSys/CSCR/githubreports/all_users_$now.csv -outputfile /c/AutoSys/CSCR/githubreports/governance_github_$now.csv -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [[ $rc != 0 ]]; then exit $rc+3000; fi
cp -f /c/AutoSys/CSCR/githubreports/governance_github_$now.csv /z/Reports/GovernanceMinder/

exit 0

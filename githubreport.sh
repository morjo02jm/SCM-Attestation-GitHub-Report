#! /bin/bash

now="$(date +'%Y_%m_%d_%H_%M_%S')"
dayofweek="$(date +'%w')"

cd /c/AutoSys/CSCR
export JAVA_HOME=$JAVA_HOME_SCM_8
#export PATH="$JAVA_HOME/bin":/c/AutoSys/CSCR/scmx86:$PATH
export PATH="$JAVA_HOME/bin":$PATH

cd /c/AutoSys/Github/githubreports
ssh -i /c/Users/toolsadmin/.ssh/id_rsa -p 122 admin@github-isl-01.ca.com "ghe-org-admin-promote -u toolsadmin"
rc=$?; if [ $rc != 0 ]; then exit $(($rc+1000)); fi

#GHE raw usage data
ruby attestation_by_owner.rb $1 > /c/AutoSys/CSCR/githubreports/attestation_github_$now.tsv
rc=$?; if [ $rc != 0 ]; then exit $(($rc+2000)); fi


cd /c/AutoSys/CSCR/githubreports
#GHE raw canned reports
## Note: because the initial curl call can result in an indirection, the curl calls are run multiple times
if [ "$dayofweek" = "0" ] 
then 
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
rc=$?; if [ $rc != 0 ]; then exit $(($rc+4000)); fi
fi

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
rc=$?; if [ $rc != 0 ]; then exit $(($rc+5000)); fi

curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 70
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 70
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 70
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 70
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 70
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 70
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
rc=$?; if [ $rc != 0 ]; then exit $(($rc+6000)); fi


cd /c/AutoSys/CSCR

# GHE Governance
if [ "$dayofweek" != "0" ]
then 
outfile="" 
else 
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_ghe_$now.tsv" 
fi
java -Xmx1024m -jar githubrepldap.jar -repofile /c/AutoSys/CSCR/githubreports/attestation_github_$now.tsv -orgfile /c/AutoSys/CSCR/githubreports/all_organizations_$now.csv -userfile /c/AutoSys/CSCR/githubreports/all_users_$now.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+7000)); fi

# Harvest Governance
if [ "$dayofweek" != "0" ]
then 
outfile=""
else 
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_harvest_$now.tsv"
fi
java -Xmx1024m -jar scmldap.jar -report $outfile -log /c/AutoSys/CSCR/scmldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+9000)); fi

# Endeavor Governance
if [ "$dayofweek" != "0" ]
then 
outfile=""
else 
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_endevor_$now.tsv"
fi
java -Xmx1024m -jar endevorrepldap.jar $outfile -log /c/AutoSys/CSCR/endevorrepldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+10000)); fi

#github.com raw usage data
cd /c/AutoSys/Github/githubreports
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware" > /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "RallyApps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "RallyTools" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
sleep 3600
ruby attestation_by_owner_githubcom.rb $2 "flowdock" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "CATechnologies" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "RallyCommunity" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
sleep 3600
ruby attestation_by_owner_githubcom.rb $2 "waffleio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "Blazemeter" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi

# github.com Governance
cd /c/AutoSys/CSCR
if [ "$dayofweek" != "0" ]
then 
outfile=""
else 
outfile="-remove -outputfile /c/AutoSys/CSCR/githubreports/governance_githubcom_$now.tsv"
fi
java -Xmx1024m -jar githubrepldap.jar -rally -repofile /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv -userfile /c/AutoSys/CSCR/github_user_mapping.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+8000)); fi

# Mainframe z/OS z/VM z/VSE Governance
if [ "$dayofweek" != "0" ]
then 
outfile=""
else 
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_mainframe_$now.tsv"
fi
java -Xmx1024m -jar zOSrepldap.jar $outfile -log /c/AutoSys/CSCR/zOSrepldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+11000)); fi

# github.com CA IDS
java -Xmx1024m -jar identityservicesldap.jar -add IdentityServicesAddUsers.csv -ADgroups IdentityServicesADGroups.tsv -contacts IdentityServicesContacts.tsv -mapfile github_user_mapping.csv -updateorg -log /c/AutoSys/CSCR/identityservicesldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+12000)); fi


#cp -f /c/AutoSys/CSCR/githubreports/governance_github*_$now.csv /z/Reports/GovernanceMinder/

exit 0

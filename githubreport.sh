#! /bin/bash

now="$(date +'%Y_%m_%d_%H_%M_%S')"
dayofweek="$(date +'%w')"

cd /c/AutoSys/CSCR; export JAVA_HOME=$JAVA_HOME_SCM_8; export PATH="$JAVA_HOME/bin":$PATH

crel="2.2"

/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/endevorrepldap/$crel/endevorrepldap-$crel.jar" /c/AutoSys/CSCR/endevorrepldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/githubrepldap/$crel/githubrepldap-$crel.jar" /c/AutoSys/CSCR/githubrepldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/identityservicesldap/$crel/identityservicesldap-$crel.jar" /c/AutoSys/CSCR/identityservicesldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/scmldap/$crel/scmldap-$crel.jar" /c/AutoSys/CSCR/scmldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/zOSrepldap/$crel/zOSrepldap-$crel.jar" /c/AutoSys/CSCR/zOSrepldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/flowdockldap/$crel/flowdockldap-$crel.jar" /c/AutoSys/CSCR/flowdockldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/artifactoryldap/$crel/artifactoryldap-$crel.jar" /c/AutoSys/CSCR/artifactoryldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/blackduckldap/$crel/blackduckldap-$crel.jar" /c/AutoSys/CSCR/blackduckldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/githubldap/$crel/githubldap-$crel.jar" /c/AutoSys/CSCR/githubldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/sonarqubeldap/$crel/sonarqubeldap-$crel.jar" /c/AutoSys/CSCR/sonarqubeldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/ccollabldap/$crel/ccollabldap-$crel.jar" /c/AutoSys/CSCR/ccollabldap.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/GitToDL/$crel/GitToDL-$crel.jar" /c/AutoSys/CSCR/GitToDL.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/github-metrics-innovation/$crel/github-metrics-innovation-$crel.jar" /c/AutoSys/CSCR/github-metrics-innovation.jar
rc=$?; if [ $rc != 0 ]; then exit $rc; fi


cd /c/AutoSys/Github/githubreports
ssh -i /c/Users/toolsadmin/.ssh/id_rsa -p 122 admin@github-isl-01.ca.com "ghe-org-admin-promote -u toolsadmin"
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

#GHE raw usage data
ruby attestation_by_owner.rb $1 > /c/AutoSys/CSCR/githubreports/attestation_github_$now.tsv
rc=$?; if [ $rc != 0 ]; then exit $rc ; fi


cd /c/AutoSys/CSCR/githubreports
#GHE raw canned reports
## Note: because the initial curl call can result in an indirection, the curl calls are run multiple times
#if [ "$dayofweek" = "0" ] 
#then 
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
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
#fi

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
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

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
rc=$?; if [ $rc != 0 ]; then exit $rc; fi


cd /c/AutoSys/CSCR

# GHE Governance
if [ "$dayofweek" != "0" ]
then 
outfile="-showghegeneric" 
else 
outfile="-showghegeneric -outputfile /c/AutoSys/CSCR/githubreports/governance_ghe_$now.tsv" 
fi
java -Xmx1024m -jar githubrepldap.jar -inputfile /c/AutoSys/CSCR/githubreports/attestation_github_$now.tsv -repofile /c/AutoSys/CSCR/githubreports/all_repositories_$now.csv -orgfile /c/AutoSys/CSCR/githubreports/all_organizations_$now.csv -userfile /c/AutoSys/CSCR/githubreports/all_users_$now.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

# Harvest Governance
if [ "$dayofweek" != "0" ]
then 
outfile=""
else 
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_harvest_$now.tsv"
fi
java -Xmx1024m -jar scmldap.jar -report $outfile -log /c/AutoSys/CSCR/scmldap
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

# github.com CA IDS
#java -Xmx1024m -jar identityservicesldap.jar -add IdentityServicesAddUsers.tsv -ADgroups IdentityServicesADGroups.tsv -contacts IdentityServicesContacts.tsv -mapfile github_user_mapping.csv -log /c/AutoSys/CSCR/identityservicesldap
#rc=$?; if [ $rc != 0 ]; then exit $rc; fi


#github.com raw usage data
sleep 3600
cd /c/AutoSys/Github/githubreports
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware" > /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyApps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyTools" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep 3600
ruby attestation_by_owner_githubcom.rb $2 "flowdock" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "CATechnologies" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "waffleio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep 3600
ruby attestation_by_owner_githubcom.rb $2 "Blazemeter" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "CASaasOps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyCommunity" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

# github.com Governance
cd /c/AutoSys/CSCR
if [ "$dayofweek" != "0" ]
then 
outfile="-remove"
else 
outfile="-remove -outputfile /c/AutoSys/CSCR/githubreports/governance_githubcom_$now.tsv"
fi
java -Xmx1024m -jar githubrepldap.jar -github.com -inputfile /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv -userfile /c/AutoSys/CSCR/github_user_mapping.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

# github-metrics-innovation
if [ "$dayofweek" != "0" ]
then
sleep 1
else
java -Xmx1024m -jar github-metrics-innovation.jar > /c/AutoSys/CSCR/github-metrics-innovation/github-metrics-innovation_$now.log 2>&1
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
mv -f github-m*.xlsx /c/AutoSys/CSCR/github-metrics-innovation/
fi

# Endeavor Governance
if [ "$dayofweek" != "0" ]
then 
outfile="-bcc mohzu02@ca.com"
else 
#outfile="-showterminated -outputfile /c/AutoSys/CSCR/githubreports/governance_endevor_$now.tsv"
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_endevor_$now.tsv"
fi
java -Xmx1024m -jar endevorrepldap.jar $outfile -log /c/AutoSys/CSCR/endevorrepldap
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

# Mainframe z/OS z/VM z/VSE Governance
if [ "$dayofweek" != "0" ]
then 
outfile="-bcc mohzu02@ca.com"
#sleep 3600
else 
#outfile="-showterminated -outputfile /c/AutoSys/CSCR/githubreports/governance_mainframe_$now.tsv"
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_mainframe_$now.tsv"
fi
java -Xmx1024m -jar zOSrepldap.jar $outfile -log /c/AutoSys/CSCR/zOSrepldap
rc=$?; if [ $rc != 0 ]; then exit $rc; fi


exit 0

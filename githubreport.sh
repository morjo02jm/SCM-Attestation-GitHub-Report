#! /bin/bash

now="$(date +'%Y_%m_%d_%H_%M_%S')"
dayofweek="$(date +'%w')"
mailme="perl /c/Strawberry/perl/bin/mailme.pl"

cd /c/AutoSys/CSCR; export JAVA_HOME=$JAVA_HOME_SCM_8; export PATH="$JAVA_HOME/bin":$PATH

crel="3.52"

/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/endevorrepldap/$crel/endevorrepldap-$crel.jar" /c/AutoSys/CSCR/endevorrepldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog endeavorrepldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/githubrepldap/$crel/githubrepldap-$crel.jar" /c/AutoSys/CSCR/githubrepldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog githubrepldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/identityservicesldap/$crel/identityservicesldap-$crel.jar" /c/AutoSys/CSCR/identityservicesldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog identityservicesldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/scmldap/$crel/scmldap-$crel.jar" /c/AutoSys/CSCR/scmldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog scmldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/zOSrepldap/$crel/zOSrepldap-$crel.jar" /c/AutoSys/CSCR/zOSrepldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog zOSrepldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/flowdockldap/$crel/flowdockldap-$crel.jar" /c/AutoSys/CSCR/flowdockldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog flowdockldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/artifactoryldap/$crel/artifactoryldap-$crel.jar" /c/AutoSys/CSCR/artifactoryldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog artifactoryldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/blackduckldap/$crel/blackduckldap-$crel.jar" /c/AutoSys/CSCR/blackduckldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog blackduckldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/githubldap/$crel/githubldap-$crel.jar" /c/AutoSys/CSCR/githubldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog githubldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/sonarqubeldap/$crel/sonarqubeldap-$crel.jar" /c/AutoSys/CSCR/sonarqubeldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog sonarqubeldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/ccollabldap/$crel/ccollabldap-$crel.jar" /c/AutoSys/CSCR/ccollabldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog ccollabldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/GitToDL/$crel/GitToDL-$crel.jar" /c/AutoSys/CSCR/GitToDL.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog GitToDL" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/github-metrics-innovation/$crel/github-metrics-innovation-$crel.jar" /c/AutoSys/CSCR/github-metrics-innovation.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog github-metrics-innovation" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --split-count 0 --flat true "p2-local/commonldap/runtime-jar/imagrejectldap/$crel/imagrejectldap-$crel.jar" /c/AutoSys/CSCR/imagrejectldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog imagrejectldap" $rc; exit $rc; fi
/c/Git/bin/jfrog rt download --flat true "p2-local/commonldap/runtime-jar/githubeventldap/$crel/githubeventldap-$crel.jar" /c/AutoSys/CSCR/githubeventldap.jar
rc=$?; if [ $rc != 0 ]; then $mailme "jfrog githubeventldap" $rc; exit $rc; fi


cd /c/AutoSys/GitHub/githubreports
ssh -i /c/Users/toolsadmin/.ssh/id_rsa -p 122 admin@github-isl-01.ca.com "ghe-org-admin-promote -u toolsadmin -y"
rc=$?; if [ $rc != 0 ]; then $mailme "ghe-org-admin-promote" $rc; exit $rc; fi

#GHE raw usage data
ruby attestation_by_owner.rb $1 > /c/AutoSys/CSCR/githubreports/attestation_github_$now.tsv
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_github" $rc; exit $rc ; fi


cd /c/AutoSys/CSCR/githubreports
#GHE raw canned reports
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 20
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 20
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 20
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 20
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
sleep 20
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_repositories.csv > all_repositories_$now.csv
rc=$?; if [ $rc != 0 ]; then $mailme "all_repositories" $rc; exit $rc; fi

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
rc=$?; if [ $rc != 0 ]; then $mailme "all_organizations" $rc; exit $rc; fi

curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 80
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 80
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 80
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 80
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 80
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
sleep 80
curl -u "toolsadmin:$1" https://github-isl-01.ca.com/stafftools/reports/all_users.csv > all_users_$now.csv
rc=$?; if [ $rc != 0 ]; then $mailme "all_users" $rc; exit $rc; fi


cd /c/AutoSys/CSCR

# GHE Governance
if [ "$dayofweek" != "3" ]
then 
outfile="-showghegeneric" 
else 
outfile="-showghegeneric -outputfile /c/AutoSys/CSCR/githubreports/governance_ghe_$now.tsv" 
fi
java -Xmx1024m -jar githubrepldap.jar -inputfile /c/AutoSys/CSCR/githubreports/attestation_github_$now.tsv -repofile /c/AutoSys/CSCR/githubreports/all_repositories_$now.csv -orgfile /c/AutoSys/CSCR/githubreports/all_organizations_$now.csv -userfile /c/AutoSys/CSCR/githubreports/all_users_$now.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then $mailme "governamce_ghe" $rc; exit $rc; fi
cp -f /c/AutoSys/CSCR/githubreports/all_users_$now.csv /c/AutoSys/CSCR/ghe_user_mapping.csv

# Harvest Governance
if [ "$dayofweek" != "3" ]
then 
outfile=""
else 
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_harvest_$now.tsv"
fi
java -Xmx1024m -jar scmldap.jar -report $outfile -log /c/AutoSys/CSCR/scmldap
rc=$?; if [ $rc != 0 ]; then $mailme "governance_harvest" $rc; exit $rc; fi

# Endeavor Governance
if [ "$dayofweek" != "3" ]
then 
outfile=""
else 
#outfile="-showterminated -outputfile /c/AutoSys/CSCR/githubreports/governance_endevor_$now.tsv"
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_endevor_$now.tsv"
fi
java -Xmx1024m -jar endevorrepldap.jar $outfile -log /c/AutoSys/CSCR/endevorrepldap
rc=$?; if [ $rc != 0 ]; then $mailme "governance_endeavor" $rc; exit $rc; fi


# Mainframe z/OS z/VM z/VSE Governance
if [ "$dayofweek" != "3" ]
then 
outfile=""
else 
#outfile="-showterminated -outputfile /c/AutoSys/CSCR/githubreports/governance_mainframe_$now.tsv"
outfile="-outputfile /c/AutoSys/CSCR/githubreports/governance_mainframe_$now.tsv"
fi
java -Xmx1024m -jar zOSrepldap.jar $outfile -log /c/AutoSys/CSCR/zOSrepldap
rc=$?; if [ $rc != 0 ]; then $mailme "governance_mainframe" $rc; exit $rc; fi


# github.com CA IDS
#java -Xmx1024m -jar identityservicesldap.jar -add IdentityServicesAddUsers.tsv -ADgroups IdentityServicesADGroups.tsv -contacts IdentityServicesContacts.tsv -mapfile github_user_mapping.csv -log /c/AutoSys/CSCR/identityservicesldap
#rc=$?; if [ $rc != 0 ]; then exit $rc; fi

# Flowdock terminated users
java  -Xmx1024m -jar flowdockldap.jar -del2 /c/GitHub/Flowutils/flowdockProblemUsers.csv -orgs /c/GitHub/Flowutils/flowdockOrgs.csv -orgusers /c/GitHub/Flowutils/flowdockOrgUsers.csv -process -log /c/AutoSys/CSCR/flowdockldap
rc=$?; if [ $rc != 0 ]; then $mailme "flowdock_terminations" $rc; exit $rc; fi

# Flowdock non-CA users
java -Xmx1024m -jar flowdockldap.jar -del2 /c/GitHub/Flowutils/flowdockNonCAUsers.csv -delay2 0 -stage2 /c/GitHub/Flowutils/flowdockToDeleteUsers.csv -orgs /c/GitHub/Flowutils/flowdockOrgs.csv -orgusers /c/GitHub/Flowutils/flowdockOrgUsers.csv -flows /c/GitHub/Flowutils/flowdockFlows.csv -flowusers /c/GitHub/Flowutils/flowdockFlowUsers.csv -flowcases /c/GitHub/Flowutils/flowdockViolations.csv -process -log /c/AutoSys/CSCR/flowdockldap
rc=$?; if [ $rc != 0 ]; then $mailme "flowdock_nonca" $rc; exit $rc; fi

#github.com raw usage data
if [ $dayofweek -eq "0" -o $dayofweek -eq "6" ]
then 
s1=1800
s2=1800
s3=600
else 
s1=7200
#s1=1800
s2=1800
s3=600
fi

sleep $s1

cd /c/AutoSys/Github/githubreports
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware" > /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallySoftware" $rc; exit $rc; fi
sleep $s2
ruby attestation_by_owner_githubcom.rb $2 "RallyApps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallyApps" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyTools" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallyTools" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "flowdock" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_flowdock" $rc; exit $rc; fi
sleep $s2
ruby attestation_by_owner_githubcom.rb $2 "CATechnologies" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_CATechnolgies" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "waffleio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_waffleio" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "Blazemeter" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_Blazemeter" $rc; exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "CASaaSOps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_CASaaSOps" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyCommunity" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallyCommunity" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyTechServices" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallyTechServices" $rc; exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "CATechnologiesPartners" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_CATechnologiesPartners" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "CA-APM" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_CA-APM" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyHackathon" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallyHackathon" $rc; exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "ca-api-gateway" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_ca-api-gateway" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "ca-api-gateway-extensions" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_ca-api-gateway-extensions" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "ca-api-gateway-examples" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_ca-api-gateway-examples" $rc; exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "mineral-ui" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_mineral-ui" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "Version-X" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_Version-X" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "CAAPIM" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_CAAPIM" $rc; exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware-cookbooks" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallySoftware-cookbooks" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware-customers" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_RallySoftware-customers" $rc; exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "sts-atlas" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_sts-atlas" $rc; exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "Runscope" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_Runscope" $rc; exit $rc; fi

#if [ $dayofweek -eq "3" ]
#then 
#sleep $s3
#ruby attestation_by_owner_githubcom.rb $2 "Fresh-Tracks" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_Fresh-Tracks" $rc; exit $rc; fi
#ruby attestation_by_owner_githubcom.rb $2 "InstantAgenda" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_InstantAgenda" $rc; exit $rc; fi
#ruby attestation_by_owner_githubcom.rb $2 "yipeeio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_yipeeio" $rc; exit $rc; fi
#sleep $s3
#ruby attestation_by_owner_githubcom.rb $2 "CodePilotai" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_CodePilotai" $rc; exit $rc; fi
#ruby attestation_by_owner_githubcom.rb $2 "WhoZoo" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then $mailme "attestation_ghc_WhoZoo" $rc; exit $rc; fi
#fi

# github.com Governance
cd /c/AutoSys/CSCR
if [ "$dayofweek" != "3" ]
then 
#outfile="-remove"
outfile=""
else 
#outfile="-remove -userorgmapreport /c/AutoSys/CSCR/githubreports/userorgmap_githubcom_$now.tsv -outputfile /c/AutoSys/CSCR/githubreports/governance_githubcom_$now.tsv"
outfile="-userorgmapreport /c/AutoSys/CSCR/githubreports/userorgmap_githubcom_$now.tsv -outputfile /c/AutoSys/CSCR/githubreports/governance_githubcom_$now.tsv"
fi
java -Xmx1024m -jar githubrepldap.jar -github.com -inputfile /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv -userfile /c/AutoSys/CSCR/github_user_mapping.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then $mailme "governance_ghc" $rc; exit $rc; fi

# github-metrics-innovation
if [ "$dayofweek" != "0" ]
then
sleep 1
else
java -Xmx1024m -jar github-metrics-innovation.jar > /c/AutoSys/CSCR/github-metrics-innovation/github-metrics-innovation_$now.log 2>&1
rc=$?; if [ $rc != 0 ]; then $mailme "github-metrics-innovation" $rc; exit $rc; fi
mv -f github-m*.xlsx /c/AutoSys/CSCR/github-metrics-innovation/
fi

exit 0

#! /bin/bash

now="$(date +'%Y_%m_%d_%H_%M_%S')"
dayofweek="$(date +'%w')"

cd /c/AutoSys/CSCR
export JAVA_HOME=$JAVA_HOME_SCM_8
#export PATH="$JAVA_HOME/bin":/c/AutoSys/CSCR/scmx86:$PATH
export PATH="$JAVA_HOME/bin":$PATH

#github.com raw usage data
cd /c/AutoSys/Github/githubreports
if [ $dayofweek -eq "0" -o $dayofweek -eq "6" ]
then 
s1=1800
s2=1800
s3=600
else 
s1=7200
s2=1800
s3=600
fi

#sleep $s1

ruby attestation_by_owner_githubcom.rb $2 "RallySoftware" > /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s2
ruby attestation_by_owner_githubcom.rb $2 "RallyApps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyTools" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "flowdock" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s2
ruby attestation_by_owner_githubcom.rb $2 "CATechnologies" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "waffleio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "Blazemeter" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "CASaaSOps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyCommunity" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyTechServices" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "CATechnologiesPartners" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "CA-APM" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallyHackathon" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "ca-api-gateway" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "ca-api-gateway-extensions" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "ca-api-gateway-examples" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "mineral-ui" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "Version-X" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "CAAPIM" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware-cookbooks" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "RallySoftware-customers" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
ruby attestation_by_owner_githubcom.rb $2 "sts-atlas" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi
sleep $s3
ruby attestation_by_owner_githubcom.rb $2 "Runscope" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $rc; fi

#if [ $dayofweek -eq "3" ]
#then 
#sleep $s3
#ruby attestation_by_owner_githubcom.rb $2 "sts-atlas" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then exit $rc; fi
#ruby attestation_by_owner_githubcom.rb $2 "Fresh-Tracks" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
#ruby attestation_by_owner_githubcom.rb $2 "InstantAgenda" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
#sleep $s3
#ruby attestation_by_owner_githubcom.rb $2 "yipeeio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then exit $rc; fi
#ruby attestation_by_owner_githubcom.rb $2 "CodePilotai" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
#rc=$?; if [ $rc != 0 ]; then exit $rc; fi
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
rc=$?; if [ $rc != 0 ]; then exit $(($rc+8000)); fi

#cp -f /c/AutoSys/CSCR/githubreports/governance_github*_$now.csv /z/Reports/GovernanceMinder/

exit 0

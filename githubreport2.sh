#! /bin/bash

now="$(date +'%Y_%m_%d_%H_%M_%S')"
dayofweek="$(date +'%w')"

cd /c/AutoSys/CSCR
export JAVA_HOME=$JAVA_HOME_SCM_8
#export PATH="$JAVA_HOME/bin":/c/AutoSys/CSCR/scmx86:$PATH
export PATH="$JAVA_HOME/bin":$PATH

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
ruby attestation_by_owner_githubcom.rb $2 "waffleio" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
sleep 3600
ruby attestation_by_owner_githubcom.rb $2 "Blazemeter" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "CASaaSOps" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi
ruby attestation_by_owner_githubcom.rb $2 "RallyCommunity" >> /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv 
rc=$?; if [ $rc != 0 ]; then exit $(($rc+3000)); fi

# github.com Governance
cd /c/AutoSys/CSCR
if [ "$dayofweek" != "0" ]
then 
outfile="-remove"
else 
outfile="-remove -outputfile /c/AutoSys/CSCR/githubreports/governance_githubcom_$now.tsv"
fi
java -Xmx1024m -jar githubrepldap.jar -github.com -inputfile /c/AutoSys/CSCR/githubreports/attestation_githubcom_$now.tsv -userfile /c/AutoSys/CSCR/github_user_mapping.csv $outfile -log /c/AutoSys/CSCR/githubrepldap
rc=$?; if [ $rc != 0 ]; then exit $(($rc+8000)); fi

#cp -f /c/AutoSys/CSCR/githubreports/governance_github*_$now.csv /z/Reports/GovernanceMinder/

exit 0

  
GITHUBREPORTS
=============

This folder catalogs several Ruby-based reports for GitHub source code attestation:

attestation_by_owner.rb  		
					Source Code Access Report 1, generated by enumerating over Organization and User ids.

attestation_by_organization.rb	
					Source Code Access Report 2, a subset of the attestaton_by_owner.rb report that only deals with Organizations.

users.rb
					Source Code Access Report 2, a limited report of SCM users from the GitHub API view.

Of the 3 reports above, only the first one should be used for generating the weekly SCM attestaton reports for GitHub Enterprise.

An Excel template is included in this folder for cut and pasting in the weekly generated results from a) the GitHub Site Admin reports for Organizations, 
Repositories, and AllUsers, plus the results from the attestation_by_owner script.

The githubreport.sh file is a Bash script used in conjuction with Autosys (or any other task scheduler) to extract csv/tsv files from the GitHub Enterprise server and assemble these files into the Excel attestation template.

A Windows wrapper, githubreport.cmd, is also provided.

Comment:  the Ruby script take as input the Personal API token for a Organization owner.  Note that the token should be for a generic user, e.g. toolsadmin,
that has been given organization admin privileges for all organizations.

Notes:
8 November 2016  Addition of separate attestation_by_owner_githubcom.rb for solely the RallySoftware organization of https://github.com 
	Note that separate GITHUB access tokens are used for the different APIs of GitHub Enterprise and github.com
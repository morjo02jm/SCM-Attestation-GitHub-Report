#Requirements:
#  The Governance Minder Attestation Report contents to contain the following data:
#
#    SCM Tool and Instance
#    The SCM Organization login id
#    The SCM Owners for the organization
#    The User id associated to the SCM Project Area
#    Whether the user is an org admin or not.

require 'octokit'

ghe_token = ARGV[0]
ghe_url = 'https://github-isl-01.ca.com/api/v3'

ghe = Octokit::Client.new(
  :access_token => ghe_token,
  :api_endpoint => ghe_url,
)

ghe.auto_paginate = true

# Write the TSV header

#puts "Organization/Team,User ID,Is Organization Admin"
puts "Organization,Owners,User ID,Is Org Admin"

# We use the Octokit interface to call the GitHub API to 
#  a) get all users and organization names
#  b) for organizations, we fetch organization members, their team associations, and the repositories they are associated with
#  c) for user repositories, we fetch the permissions

ghe.all_users().each do |org|
	if org.type == 'Organization'
		admins = ghe.organization_members(org.login, { :role => 'admin' }).map(&:login)
		
		owners = ""
		ghe.organization_members(org.login, { :role => 'admin' }).each do |admin|
		    if admin.login == 'toolsadmin'
			else
				if owners == ''
					owners = "#{admin.login}"
				else
					owners = "#{owners};" + "#{admin.login}"
				end # blank
			end # toolsadmin
		end #each admin

		ghe.organization_members(org.login).each do |member|
			org_admin = admins.include?(member.login) ? 'Yes' : 'No'
			puts "#{org.login},#{owners},#{member.login},#{org_admin}"
		end #each team member
	end # is organization
end #each Organization


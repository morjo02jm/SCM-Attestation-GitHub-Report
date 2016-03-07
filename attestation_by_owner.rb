#Requirements:
#The Source Code Attestation Report contents to contain the following data
#
#    SCM Tool and Instance
#    The SCM Repository Name
#    The SCM Repository Type (Public or Private Repository)
#    The RnD SCM Project Area name
#    The RnD SCM Project Team Area name
#    The User Name associated to the SCM Project Area
#    The User Account Name associated to the SCM Project Area used to access the SCM application
#    The User SCM Project Roles - the type of access the user has to the SCM Project Area

require 'octokit'

ghe_token = ARGV[0]
ghe_url = 'https://github-isl-01.ca.com/api/v3'

ghe = Octokit::Client.new(
  :access_token => ghe_token,
  :api_endpoint => ghe_url,
)

ghe.auto_paginate = true

# Write the TSV header

puts "Organization\tTeam\tRepository\tRepository Type\tUser ID\tCan Push\tCan Pull\tCan Admin\tIs Organization Admin"


# We use the Octokit interface to call the GitHub API to 
#  a) get all users and organization names
#  b) for organizations, we fetch organization members, their team associations, and the repositories they are associated with
#  c) for user repositories, we fetch the permissions

ghe.all_users().each do |org|
	if org.type == 'Organization'
		admins = ghe.organization_members(org.login, { :role => 'admin' }).map(&:login)

		ghe.org_teams(org.login).each do |team|
			begin
			  repos = ghe.team_repositories(team.id, {:accept => 'application/vnd.github.ironman-preview+json'}).map{ |r| [r.name, r.permissions, r.private] }
			rescue  Octokit::NotFound
			  repos = ['']
			end

			ghe.team_members(team.id).each do |member|
			  repos.each do |repo|
				push = repo[1]["push"] ? 'Yes' : 'No'
				pull = repo[1]["pull"] ? 'Yes' : 'No'
				admin = repo[1]["admin"] ? 'Yes' : 'No'
				org_admin = admins.include?(member.login) ? 'Yes' : 'No'
				type = repo[2]? 'Private' : 'Public'
				puts "#{org.login}\t#{team.name}\t#{repo[0]}\t#{type}\t#{member.login}\t#{push}\t#{pull}\t#{admin}\t#{org_admin}"
			  end #each repo
			end #each team member
		end #each team
	else #org.type == 'User'
		begin
		  repos = ghe.repos(org.login, {:accept => 'application/vnd.github.ironman-preview+json'}).map{ |r| [r.name, r.permissions, r.private] }
		rescue  Octokit::NotFound
		  repos = ['']
		end
		
        repos.each do |repo|
				orgname = '***User Repository***'
		        team = org.login
				org_admin = 'N/A'
                reponame = repo[0]
				push = repo[1]["push"] ? 'Yes' : 'No'
				pull = repo[1]["pull"] ? 'Yes' : 'No'
				admin = repo[1]["admin"] ? 'Yes' : 'No'
				type = repo[2]? 'Private' : 'Public'
				puts "#{orgname}\t#{team}\t#{reponame}\t#{type}\t#{org.login}\t#{push}\t#{pull}\t#{admin}\t#{org_admin}"		
        end # user repos	
	end #check user type
end #each Organization


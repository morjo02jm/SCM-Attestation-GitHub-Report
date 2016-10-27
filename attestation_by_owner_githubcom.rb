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
ghe_url = 'https://api.github.com'

ghe = Octokit::Client.new(
  :access_token => ghe_token,
  :api_endpoint => ghe_url,
)

ghe.auto_paginate = true
#STDOUT.sync=true

# Write the TSV header

puts "Organization\tTeam\tRepository\tRepository Type\tUser ID\tCan Push\tCan Pull\tCan Admin\tIs Organization Admin"


# We use the Octokit interface to call the GitHub API to 
#  a) get all users and organization names
#  b) for organizations, we fetch organization members, their team associations, and the repositories they are associated with
#  c) for user repositories, we fetch the permissions


org = ghe.org('RallySoftware')
if org.type == 'Organization'
	admins = ghe.organization_members(org.login, { :role => 'admin' }).map(&:login)
				
# repositories by teams	
	ghe.org_teams(org.login).each do |team|
		begin
		  trepos = ghe.team_repositories(team.id, {:accept => 'application/vnd.github.ironman-preview+json'}).map{ |r| [r.name, r.permissions, r.private] }
		rescue  Octokit::NotFound
		  trepos = ['']
		end

		ghe.team_members(team.id).each do |member|
			trepos.each do |repo|
				push = repo[1]["push"] ? 'Yes' : 'No'
				pull = repo[1]["pull"] ? 'Yes' : 'No'
				admin = repo[1]["admin"] ? 'Yes' : 'No'
				org_admin = admins.include?(member.login) ? 'Yes' : 'No'
				type = repo[2]? 'Private' : 'Public'
				puts "#{org.login}\t#{team.name}\t#{repo[0]}\t#{type}\t#{member.login}\t#{push}\t#{pull}\t#{admin}\t#{org_admin}"
			end #each repo
		end #each team member
	end #each team

# repositories by organization		
	begin
	  orepos = ghe.org_repositories(org.login, {:accept => 'application/vnd.github.ironman-preview+json'}).map{ |r| [r.name, r.permissions, r.private, r.owner, r.id] }
	rescue  Octokit::NotFound
	  orepos = ['']
	end

	orepos.each do |repo|
		ghe.organization_members(org.login).each do |member|
		# show owners
			if (admins.include?(member.login)) 
			#if (member.login == repo[3]["login"])
				org_admin = 'Yes'
				push = repo[1]["push"] ? 'Yes' : 'No'
				pull = repo[1]["pull"] ? 'Yes' : 'No'
				admin = repo[1]["admin"] ? 'Yes' : 'No'
				type = repo[2]? 'Private' : 'Public'
				puts "#{org.login}\t***Owner***\t#{repo[0]}\t#{type}\t#{member.login}\t#{push}\t#{pull}\t#{admin}\t#{org_admin}"
			end # admin
		end # each org member
		
		# show collaborators
		begin
			collabs = ghe.collabs(repo[4], {:accept => 'application/vnd.github.ironman-preview+json'}).map{ |c| [c.login, c.permissions]}
		rescue  Octokit::NotFound
			collabs = ['']
		rescue Octokit::RepositoryUnavailable
			collabs = ['']
		end
		
		collabs.each do |collab|
			if (!admins.include?(collab[0]))
				org_admin = 'No'
				if (collab[1] != nil)
					push  = collab[1]["push"] ? 'Yes' : 'No'
					pull  = collab[1]["pull"] ? 'Yes' : 'No'
					admin = collab[1]["admin"] ? 'Yes' : 'No'
				else
					push  = 'No'
					pull  = 'No'
					admin = 'No'
				end 
				type = repo[2]? 'Private' : 'Public'
				puts "#{org.login}\t***Collaborator***\t#{repo[0]}\t#{type}\t#{collab[0]}\t#{push}\t#{pull}\t#{admin}\t#{org_admin}"
			end # not owner			
		end # collaborators
	end #each repo
end #check user type

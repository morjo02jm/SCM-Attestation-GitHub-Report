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

# We use the Octokit interface to call the GitHub API to 
#  a) get all users and organization names
#  b) for organizations, we fetch organization members, their team associations, and the repositories they are associated with

def print_orgs(ghe, orgs)
  orgs.each do |org|
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
        end
      end
    end
  end
end

ghe.orgs
last_response = ghe.last_response

puts "Organization\tTeam\tRepository\tRepository Type\tUser ID\tCan Push\tCan Pull\tCan Admin\tIs Organization Admin"
print_orgs(ghe, last_response.data)

#this piece of coding handles the pagination restriction in the ghe.orgs request

until last_response.rels[:next].nil?
  last_response = last_response.rels[:next].get
  print_orgs(ghe, last_response.data)
end



#The Source Code Access Review Report to contain the following data
#
#    The User Account ID
#    The User Display Name
#    The User email address if available from the SCM Tool
#    The User Account ID status (Active or Archived or Disabled)

# This report should not be used, because the Site Admin User Report is more complete.

require 'octokit'

ghe_token = ARGV[0]
ghe_url = 'https://github-isl-01.ca.com/api/v3'

ghe = Octokit::Client.new(
  :access_token => ghe_token,
  :api_endpoint => ghe_url,
)

ghe.auto_paginate = true

puts "Id\tPMFKEY\tSite Admin\tName\tEmail\tLast Updated"
ghe.all_users().each do |user|

	if user.type == 'User'
		userdetails = ghe.user(user.login)
		siteadmin = user.site_admin ? 'Yes' : 'No'
		hireable = userdetails.hireable ? 'Yes' : 'No'
		puts "#{user.id}\t#{user.login}\t#{siteadmin}\t#{userdetails.name}\t#{userdetails.email}\t#{userdetails.updated_at}"
	end
end

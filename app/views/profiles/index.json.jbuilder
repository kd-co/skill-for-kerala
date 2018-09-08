json.status 200
json.users @users do |user|
	json.partial! 'profile_details', user: user
end

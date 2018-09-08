if @error or not @profile
	json.status 404
else
	json.status 200
	json.partial! 'profile_details', user: @profile.user
end

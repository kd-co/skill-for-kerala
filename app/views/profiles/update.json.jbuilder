json.status 200
if @user.errors.present?
  json.errors @user.errors.messages
else
  json.partial! 'profile_details', user: @user
end

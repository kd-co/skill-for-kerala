json.extract! user, :email, :first_name, :last_name, :image, :name
json.skills do
	json.array! user.skills, :skill
end
json.location user.profile.try(:location)
json.bio user.profile.try(:bio)
json.profile_id user.profile.try(:id)

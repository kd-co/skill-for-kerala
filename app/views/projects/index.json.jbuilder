json.status 200
json.total_amount @projects.sum(:amount)
json.projects @projects do |project|
  json.extract! project, :owner_email, :owner_name, :amount, :description
  json.creator projects.user.try(:first_name)
end

if @project.errors.blank?
  json.message 'Project created'
else
  json.errors @project.errors.messages
end

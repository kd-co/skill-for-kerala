json.status 200
if @errors.blank?
  json.message 'Approved!'
else
  json.errors @errors
end


module ApplicationHelper
  def angular_javascript_tag(name)
    javascript_include_tag "http://localhost:4200/#{name}.bundle.js"
  end
end

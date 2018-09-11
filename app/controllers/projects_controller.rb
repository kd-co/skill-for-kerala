class ProjectsController < ApplicationController
  api :POST, '/projects/'
  param :project, Hash, required: true do
    param :owner_email, String
    param :owner_name, String
    param :amount, Float
    param :description, String
  end
  def create
    @project =Project.new(project_params)
    @project.user = current_user
    @project.save()
  end

  def project_params
    params.require(:project).permit(:owner_email, :owner_name, :amount, :description)
  end
end

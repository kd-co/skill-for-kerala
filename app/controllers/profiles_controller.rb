class ProfilesController < ApplicationController
  before_action :set_profile
  api :GET, '/profiles'
  param :key, String, desc: "optional filter search", required: false
  def index
    filter = params[:key]
    if filter
      @users = User.includes(:profile, :skills).where(
        'skill ILIKE ? or bio ILIKE ? or location ILIKE ? or first_name ILIKE ? and approved = ?',
        "%#{filter}%", "%#{filter}%", "%#{filter}%", "%#{filter}%", true).references(:skills, :profile)
    else
      @users = User.includes(:profile, :skills).where('approved = ?', false)
    end
  end

  api :GET, '/profiles/:id'
  param :id, :number, desc: "optional filter search", required: false
  def show
  end

  api :PUT, '/profiles/:id'
  param :id, :number, desc: "optional filter search", required: false
  def update
    authorize @profile
    @profile.update(profile_params)
  end

  def create
    @profile = current_user.profile ? current_user.profile : current_user.build_profile
    @profile.update(profile_params)
  end

  private

  def set_profile
    begin
      @profile = Profile.find_by_id(params[:id])
    rescue ActiveRecord::RecordNotFound
      @error = "Record Not found"
    end
  end

  def update_profile(params)
    @profile.update(profile_params)
  end

  def profile_params
    params.permit(:location, :bio)
  end
end

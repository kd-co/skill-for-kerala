class ProfilesController < ApplicationController
  before_action :set_profile, except: [:create]
  skip_before_action :verify_authenticity_token, only: [:index]

  api :GET, '/profiles'
  param :key, String, desc: 'optional filter search', required: false
  def index
    filter = params[:key]
    @users = if filter
               User.includes(:profile, :skills).where(
                 'skill ILIKE ? or bio ILIKE ? or location ILIKE ? or first_name ILIKE ? and approved = ?',
                 "%#{filter}%", "%#{filter}%", "%#{filter}%", "%#{filter}%", true
               ).references(:skills, :profile)
             else
               User.includes(:profile, :skills).where('approved = ?', false)
             end
  end

  api :GET, '/profiles/:id'
  param :id, :number, required: true
  def show; end

  api :PUT, '/profiles/:id'
  param :id, :number, desc: 'optional filter search', required: false
  param :user, Hash, required: true do
    param :first_name, String
    param :last_name, String
    param :email, String
    param :image, String
    param :available, [true, false]
    param :profile_attributes, Hash, desc: 'profile data' do
      param :location, String
      param :bio, String
      param :available_hours, Float
    end
    param :skills_attributes, %i[id skill _destroy]
  end
  def update
    authorize @profile
    @user = @profile.user
    @user.update(profile_params)
  end

  api :POST, '/profiles/'
  param :user, Hash, required: true do
    param :first_name, String
    param :last_name, String
    param :email, String
    param :image, String
    param :available, [true, false]
    param :profile_attributes, Hash, desc: 'profile data' do
      param :location, String
      param :bio, String
      param :available_hours, Float
    end
    param :skills_attributes, %i[id skill _destroy]
  end
  def create
    @profile = current_user.profile || current_user.build_profile
    @user = @profile.user
    @user.update(profile_params)
  end

  api :PUT, '/profiles/:id/approve'
  param :id, :number, required: true
  def approve
    authorize @profile
    @errors = @profile.user.approved!
  end

  private

  def set_profile
    @profile = Profile.find_by_id(params[:id])
  rescue ActiveRecord::RecordNotFound
    @error = 'Record Not found'
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email, :image, :available,
                                 skills_attributes: %i[id skill _destroy],
                                 profile_attributes: %i[location bio available_hours])
  end
end

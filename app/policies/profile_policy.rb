class ProfilePolicy
  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def update?
    user and ((user.profile and user.profile == profile) or user.super_admin?)
  end

  def approve?
    user and user.super_admin?
  end
end

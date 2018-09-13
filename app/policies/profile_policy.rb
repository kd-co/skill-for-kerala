class ProfilePolicy
  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def update?
    user && ((user.profile && (user.profile == profile)) || user.super_admin?)
  end

  def approve?
    user&.super_admin?
  end
end

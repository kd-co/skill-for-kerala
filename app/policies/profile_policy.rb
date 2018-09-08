class ProfilePolicy
  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def update?
    user.profile and user.profile == profile
  end
end

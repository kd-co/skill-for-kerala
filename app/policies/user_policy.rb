class UserPolicy
  attr_reader :user, :instance

  def initialize(user, instance)
    @user = user
    @instance = instance
  end

  def contact?
    user&.client? && instance.employee?
  end
end

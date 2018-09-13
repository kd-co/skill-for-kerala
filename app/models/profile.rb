class Profile < ApplicationRecord
  belongs_to :user
  has_many :skills, through: :user

  scope :approved, -> { joins(:user).where(users: { approved: true }) }
end

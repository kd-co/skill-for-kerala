class User < ApplicationRecord
  include ThreadUtility
  has_many :skills, class_name: :UserSkill, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :projects, dependent: :destroy
  enum role: %w[client employee super_admin]

  accepts_nested_attributes_for :skills,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :profile

  scope :approved, -> { where(approved: true) }
  scope :available, -> { where(available: true) }

  validates :first_name, :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth, params)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.role = params['user_type'] if params['user_type']
    end
  end

  def name
    [first_name, last_name].join(' ')
  end

  def name=(name)
    self.first_name, self.last_name = name.split(' ')
  end

  def approved!
    errors = []
    self.approved = true
    if save
      thread do
        UserMailer.send_approval(self)
      end
    else
      errors = self.errors.messages
    end
    errors
  end

  def contact!(client)
    thread do
      UserMailer.send_contact_request(self, client)
    end
  end
end

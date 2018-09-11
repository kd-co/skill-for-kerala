class User < ApplicationRecord
  has_many :skills, class_name: :UserSkill, dependent: :destroy
  has_one :profile, dependent: :destroy
  enum role: %w(client employee super_admin)

  accepts_nested_attributes_for :skills,
    :reject_if => :all_blank,
    :allow_destroy => true
  accepts_nested_attributes_for :profile
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
    if self.save
      UserMailer.send_approval(self)
    else
      errors = self.errors.messages
    end
    return errors
  end

  def contact!(client)
    UserMailer.send_contact_request(self, client)
  end
end

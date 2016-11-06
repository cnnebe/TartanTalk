#Modify this when expanding user
class User < ApplicationRecord
  has_many :messages
  has_many :chatrooms, through: :messages

  validates :username, presence: false, uniqueness: false
 # validates :role, inclusion: { in: %w[admin professional peer student], message: "is not a recognized role in system" }

  # Scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :by_role,      -> { order(:role) }
  scope :alphabetical, -> { order(:username) }
  scope :staff,    -> { where.not(role: 'student') }
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

   ROLES = [['Administrator', :admin],['Professional Counselor', :professional],['Peer Counselor', :peer],['Student',:student]]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.username = "user-#{ SecureRandom.hex(10)}" 
      user.save!
    end
  end

  def online?
    updated_at > 10.minutes.ago
  end

end
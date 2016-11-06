class User < ApplicationRecord
  has_many :messages
  has_many :chatrooms, through: :messages
  has_one :staff

  validates :username, presence: false, uniqueness: true
  validates :name, presence: true, uniqueness: false
  validates :role, inclusion: { in: %w[admin professional peer student], message: "is not a recognized role." }, presence: true

  # Scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :by_role,      -> { order(:role) }
  scope :alphabetical, -> { order(:username) }
  scope :nonstaff, -> { where(role: 'student') }
  scope :staff,    -> { where.not(role: 'student') }
  # Source: https://www.google.com/url?q=http://stackoverflow.com/questions/5504130/whos-online-using-devise-in-rails&sa=D&ust=1478418571973000&usg=AFQjCNE7adDErNZZrwNgpbBYVdnJyvVemA
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

  # Used for Authorization and Staff Assignment
  ROLES = [['Administrator', :admin],['Professional Counselor', :professional],['Peer Counselor', :peer],['Student',:student]]

  # Creates User from Google Authentication
  # Source: https://richonrails.com/articles/google-authentication-in-ruby-on-rails
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

  # Checks to see if a user is online
  # Source: https://www.google.com/url?q=http://stackoverflow.com/questions/5504130/whos-online-using-devise-in-rails&sa=D&ust=1478418571973000&usg=AFQjCNE7adDErNZZrwNgpbBYVdnJyvVemA
  def online?
    updated_at > 10.minutes.ago
  end
end
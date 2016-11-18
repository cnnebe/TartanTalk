# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :topic, presence: true, uniqueness: false, case_sensitive: false
  validates :user_id, presence: false
  validates :counselor, presence: false
  before_validation :sanitize, :slugify

  validates :counselor_type, inclusion: { in: %w[all professional peer], message: "is not a recognized counselor type." }, presence: true

  # Scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  scope :recent,      -> { order(:updated_at) }
  scope :alphabetical, -> { order(:topic) }

  scope :anonymous, -> { where(anonymous: true) }
  scope :nonanonymous, -> { where(anonymous: false) }

  scope :emergency, -> { where(emergency: true) }
  scope :nonemergency, -> { where(emergency: false) }

  scope :professional, -> {where("counselor_type != ?", 'peer')}
  scope :peer, -> {where("counselor_type != ?", 'professional')}

  scope :staff, -> {where(staff: true)}
  scope :nonstaff, -> {where(staff: false)}

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.topic.downcase.gsub(" ", "-")
  end

  def sanitize
    self.topic = self.topic.strip
  end

  # Counselor types for creation form.
  TYPES = [['all', :all],['Professional Counselor', :professional],['Peer Counselor', :peer]]
  
  

end

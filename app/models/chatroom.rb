# Adapted from: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :topic, presence: true, uniqueness: true, case_sensitive: false
  before_validation :sanitize, :slugify

  validates :counselor_type, inclusion: { in: %w[all professional peer], message: "is not a recognized counselor type." }, presence: true

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

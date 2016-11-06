#Chatroom Management. No need to modify yet
class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :topic, presence: true, uniqueness: true, case_sensitive: false
  before_validation :sanitize, :slugify

  validates :counselor_type, inclusion: { in: %w[all professional peer], message: "is not a recognized counselor type." }, presence: true
  #validates_inclusion_of :counselor, in: User.staff.map{|key, value| value}, message: "is not an option"

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.topic.downcase.gsub(" ", "-")
  end

  def sanitize
    self.topic = self.topic.strip
  end

  TYPES = [['all', :all],['Professional Counselor', :professional],['Peer Counselor', :peer]]
  

end

class Staff < ApplicationRecord
  belongs_to :user
  
  validates :gender, inclusion: { in: %w[male female other], message: "is not a recognized gender." }, presence: true
  validates :bio, presence: true, uniqueness: false
  validates :user_id, presence: true, uniqueness: true

  #Used for gender selection
  GENDER = [['Male', :male],['Female', :female],['Other', :other]]

  # Scopes
  scope :professional, -> { where(is_professional: true) }
  scope :peer, -> {where(is_professional: false)}

end

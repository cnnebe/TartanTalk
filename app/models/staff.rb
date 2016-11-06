class Staff < ApplicationRecord
  belongs_to :user
  
  validates :gender, inclusion: { in: %w[male female other], message: "is not a recognized gender." }, presence: true
  validates :bio, presence: true, uniqueness: false
  validates :is_professional, presence: true, uniqueness: false
  validates :user_id, presence: true, uniqueness: true

  #Used for gender selection
  GENDER = [['Male', :male],['Female', :female],['Other', :other]]

end

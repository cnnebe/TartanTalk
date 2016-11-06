class Staff < ApplicationRecord
  belongs_to :user

  GENDER = [['Male', :male],['Female', :female],['Other', :other]]

end

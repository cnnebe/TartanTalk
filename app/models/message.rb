#Messages could use additional things (like validations if we filter things)
class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
end

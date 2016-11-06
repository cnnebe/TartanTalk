# Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
# Future Development: Filter bad words.
class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
end

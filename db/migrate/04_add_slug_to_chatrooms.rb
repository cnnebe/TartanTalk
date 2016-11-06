#Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable
class AddSlugToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :slug, :string
  end
end

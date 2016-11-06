#Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable
class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
      t.timestamps
    end
  end
end

class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms do |t|
      t.string :topic
      t.string :counselor_type, default: 'all'
      t.string :counselor, default: 'all'
      t.boolean :active, default: true
      t.boolean :staff, default: false
      t.boolean :private, default: true
      t.boolean :emergency, default: false
      t.boolean :anonymous, default: false
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end

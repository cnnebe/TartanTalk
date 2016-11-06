class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|
      t.string :gender
      t.string :bio
      t.boolean :is_professional
      t.integer :user_id

      t.timestamps
    end
  end
end

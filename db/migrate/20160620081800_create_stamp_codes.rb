class CreateStampCodes < ActiveRecord::Migration
  def change
    create_table :stamp_codes do |t|
      t.string :code
      t.integer :user_id
      t.integer :stamp_id

      t.timestamps null: false
    end
  end
end

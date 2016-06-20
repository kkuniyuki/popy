class CreateStampCodes < ActiveRecord::Migration
  def change
    create_table :stamp_codes do |t|
      t.string :code
      t.string :user_id
      t.string :stamp_id

      t.timestamps null: false
    end
  end
end

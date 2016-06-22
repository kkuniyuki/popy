class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :image
      t.string :status1, default: false
      t.string :status2, default: false
      t.string :status3, default: false
      t.string :status4, default: false
      t.integer :user_id 
      t.timestamps null: false
    end
  end
end

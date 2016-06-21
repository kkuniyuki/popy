class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.binary :image
      t.string :status1, null: false
      t.string :status2, null: false
      t.string :status3, null: false
      t.string :status4, null: false
      t.integer :user_id 

      t.timestamps null: false
    end
  end
end

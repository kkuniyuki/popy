class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.binary :image
      t.string :status1
      t.string :status2
      t.string :status3
      t.string :status4
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

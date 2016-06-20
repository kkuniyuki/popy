class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.image :image
      t.string :status

      t.timestamps null: false
    end
  end
end

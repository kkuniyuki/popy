class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.image :image

      t.timestamps null: false
    end
  end
end

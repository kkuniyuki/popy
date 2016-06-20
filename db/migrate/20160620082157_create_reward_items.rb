class CreateRewardItems < ActiveRecord::Migration
  def change
    create_table :reward_items do |t|
      t.string :product_name
      t.string :image
      t.string :description
      t.string :catelogue
      t.string :map_id

      t.timestamps null: false
    end
  end
end

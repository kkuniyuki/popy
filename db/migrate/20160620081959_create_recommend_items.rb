class CreateRecommendItems < ActiveRecord::Migration
  def change
    create_table :recommend_items do |t|
      t.string :product_name
      t.binary :image
      t.string :url
      t.integer :stamp_id

      t.timestamps null: false
    end
  end
end

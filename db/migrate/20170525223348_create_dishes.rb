class CreateDishes < ActiveRecord::Migration[5.1]
  def change
  	create_table :dishes do |t|
  		t.string :name
  		t.float :price
  		t.boolean :vegetarian
  		t.boolean :gluten_free
  		t.integer :restaurant_id
  	end
  end
end

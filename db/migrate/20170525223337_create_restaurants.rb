class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
  	create_table :restaurants do |t|
  		t.string :name
  		t.integer :city_id
  	end
  end
end

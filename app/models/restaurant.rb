class Restaurant < ActiveRecord::Base
	has_many :dishes
	belongs_to :city
end
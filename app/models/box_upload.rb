class BoxUpload < ApplicationRecord
	 belongs_to :user
	 has_one_attached :box_file 
	 validates :box_file, attached: true
end

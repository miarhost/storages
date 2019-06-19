class BoxUpload < ApplicationRecord
	 belongs_to :user
	 has_one_attached :box_file 
	 validates :box_file, attached: true

	 def box_path
	 	 ActiveStorage::Blob.service.send(:path_for, box_file.key)
	 end

	 def box_filename
	   box_file.filename.to_s
	 end
end


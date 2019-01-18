class SampleUpload < ApplicationRecord

	 belongs_to :sample_folder, optional: true
	 has_one_attached :attachment
    
end

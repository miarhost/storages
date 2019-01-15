class SampleUpload < ApplicationRecord

	 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	 
	 belongs_to :sample_folder, optional: true
	 has_one_attached :attachment
	 validates :attachment, presence: true
  validates :email, 
          length: { minimum: 12, maximum: 255 },
          format: {with: VALID_EMAIL_REGEX },
          uniqueness: true,
          :allow_nil => true
    
end

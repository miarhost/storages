class SampleUpload < ApplicationRecord
	include Geturlable
	 belongs_to :sample_folder, optional: true
	 has_one_attached :attachment
	 scope :with_eager_loaded_attachment, -> { eager_load(attachment_attachment: :blob) }
end

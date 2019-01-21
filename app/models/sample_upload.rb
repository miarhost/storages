class SampleUpload < ApplicationRecord

	  include Rails.application.routes.url_helpers

	 belongs_to :sample_folder, optional: true
	 has_one_attached :attachment
	 scope :with_eager_loaded_attachment, -> { eager_load(attachment_attachment: :blob) }

  def cover_url 
    rails_blob_path(self.cover, disposition: "attachment", only_path: true)
  end


end

class SampleUpload < ApplicationRecord

	 include Rails.application.routes.url_helpers

	 belongs_to :sample_folder, optional: true
	 has_one_attached :singleupload
	 scope :with_eager_loaded_singleupload, -> { eager_load(singleupload_attachment: :blob) }

  def new_url
    rails_blob_path(self.singleupload, disposition: "attachment", only_path: true)
  end

end


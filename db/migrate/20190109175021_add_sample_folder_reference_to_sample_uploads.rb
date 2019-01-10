class AddSampleFolderReferenceToSampleUploads < ActiveRecord::Migration[5.2]
  def change
    add_reference :sample_uploads, :sample_folder, foreign_key: true
  end
end

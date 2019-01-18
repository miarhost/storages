class RemoveColumnsFromSampleUploads < ActiveRecord::Migration[5.2]
  def change
    remove_column :sample_uploads, :attachment, :string
    remove_column :sample_uploads, :email, :string
  end
end

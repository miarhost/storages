class RemoveBoxFileFromBoxUpload < ActiveRecord::Migration[5.2]
  def change
    remove_column :box_uploads, :box_file, :string
  end
end

class CreateBoxUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :box_uploads do |t|
      t.string :box_file

      t.timestamps
    end
  end
end

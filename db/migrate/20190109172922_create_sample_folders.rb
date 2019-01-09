class CreateSampleFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :sample_folders do |t|
      t.string :url
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

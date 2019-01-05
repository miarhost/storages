class CreateSampleUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :sample_uploads do |t|
      t.string :attachment
      t.string :email

      t.timestamps
    end
  end
end

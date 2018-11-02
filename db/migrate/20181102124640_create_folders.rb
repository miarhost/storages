class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :title
      t.integer :filenum
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

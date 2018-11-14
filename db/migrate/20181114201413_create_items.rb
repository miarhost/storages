class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :attachment

      t.timestamps
    end
  end
end

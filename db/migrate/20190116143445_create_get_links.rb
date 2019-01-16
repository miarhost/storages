class CreateGetLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :get_links do |t|
      t.string :email

      t.timestamps
    end
  end
end

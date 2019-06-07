class AddUserReferenceToBoxUploads < ActiveRecord::Migration[5.2]
  def change
    add_reference :box_uploads, :user, foreign_key: true
  end
end

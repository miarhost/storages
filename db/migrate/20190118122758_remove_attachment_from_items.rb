class RemoveAttachmentFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :attachment, :string
  end
end

class Item < ApplicationRecord
 
  belongs_to :folder
  has_one_attached :attachment

end

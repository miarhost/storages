class Item < ApplicationRecord
 
 belongs_to :folder#, :counter_cache => true
 
 has_one_attached :attachment

end

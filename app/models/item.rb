

class Item < ApplicationRecord
 
 belongs_to :folder
 

 def item_params
  require_params = params.require(:item).permit(:attachment)
  require_params[:attachment] = item_params[:attachment].present? ? UploadIO.new(item_params[:attachment].tempfile, item_params[:attachment].content_type, iteml_params[:attachment].original_filename) : nil
  require_params
 end


end

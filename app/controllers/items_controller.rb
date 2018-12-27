class ItemsController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_user!
before_action :set_folder

 def index
 	@items = Item.all
 update_total_views
 end
 
 def new
 	@item = Item.new
 end

 def show
 	@item = Item.find(params[:id])
  increment = @item.views +=1 
  @item.update_attribute "views", increment
 end

 def create
  @item = @folder.items.build(item_params)
  @item.folder.user_id = current_user.id
  if @item.save
  flash[:success] = "File added to your folder"
  redirect_to folder_path(@folder)
  else
  flash[:notice] = "File can't be saved"
  redirect_to folders_path(@folders)
  end
 end

 def destroy
 	@item = Item.find(params[:id])
 	@item.destroy
 	respond_to do |format|
 	 format.html { redirect_to folder_path(@folder), notice: 'File is deleted!' }
   format.json { head :no_content }
  end
 end

 def upload_to_gc
  GcAttachmentUploaderService.call(params[:attachment])
 end 

 def download 
  @item.attachment.download
 end 

private 

 def item_params
 	params.require(:item).permit(:attachment, :folder_id, :id, :views)
 end

def set_folder
 @folder = Folder.find(params[:folder_id])
end
 
end

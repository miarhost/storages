class ItemsController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_user!
before_action :set_folder

 def index
 	@items = Item.all
 end
 
 def new
 	@item = Item.new
 end

 def show
 	@item = Item.find(params[:id])
 end

 def edit
  @item = @folder.items.find(params[:id])
 end
 
 def create
 	#@folder = Folder.find_by(params[:folder_id])
  @item = @folder.items.build(item_params)
  #AttachmentUploaderService.call(params[:attachment])
  #@item.attachment.attach(io: io, filename: "sample.jpg")
  if @item.save
  flash[:success] = "File added to your folder"
  redirect_to @item
  else
  redirect_to folder_path(@folder)
  end
 end

 def update
 	@item.update
 	respond_to do |format|
 		format.html { redirtect_to @item, flash: "File upload is changed" }
 		format.json { render :show, status: :ok, location: @item }
 	end
 end

private 

 def item_params
 	params.require(:item).permit(:attachment, :folder_id, :id)
 end

def set_folder
 @folder = Folder.find_by(params[:folder_id])
end
 
end

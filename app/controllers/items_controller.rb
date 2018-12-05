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
  @item = AttachmentUploaderService.call(params[:attachment])
  if @item.save
  flash[:success] = "File added to your folder"
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
 	params.permit(:item).require(:attachment)
 end

 def set_folder
 	@folder = Folder.find_by(params[:folder_id])
 end
 
end

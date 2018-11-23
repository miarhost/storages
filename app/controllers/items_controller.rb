class ItemsController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_user!
 
 def index
 	@items = Item.all
 end
 
 def new
 	@item = Item.new
 end

 def show
 	@item = Item.find(params[:id])
 end

 def create
  @item = AttachmentUploaderService.call(params)
  if @item.save
  flash[:success] = "File added to your folder"
  else
  redirect_to folder_path(@folder)
  end
 end

private 

 def item_params
 	params.permit(:item).require(:attachment)
 end
end

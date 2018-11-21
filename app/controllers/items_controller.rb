class ItemsController < ApplicationController

before_action :authenticate_user!
 
 def new
 	@item = Item.new
 end

 def show
 	@item = Item.find(params[:id])
 end

 def create
  @item = ItemUploaderService.call({item: resource}).perform
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

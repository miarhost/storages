class ItemsController < ApplicationController

before_action :authenticate_user!

 def create
  @item = Services::Items::Builder.call(params)
  if @item.save
  flash[:success]="File added to your folder"
  else
  redirect_to folder_path(@folder)
  end
 end

private 

 def item_params
 	params.permit(:item).require(:attachment)
 end
end

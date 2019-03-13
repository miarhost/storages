class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_folder
  rescue_from ActionController::ParameterMissing do |exception|     
    redirect_to home_path 
    flash[:notice] = "Add a file to upload!"
  end

  def index
 	  @items = Item.all
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
    attachment = params[:item][:attachment]
      respond_to do |format|
      if @item.save
        if attachment
          @item.attachment.attach(attachment)
        end
        format.html { redirect_to @folder, notice: "File was added to your folder"}
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :enprocessable_entity }
      end
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

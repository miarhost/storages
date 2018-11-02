class FoldersController < ApplicationController
 
 before_action :authenticate_user!
 before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def new
  	@folder = Folder.new
  end
  
  def index
  	@folders = Folder.where(user_id: current_user.id)
  end

  def edit

  end

  def create 
  	@folder = current_user.folders.build(folder_params)
  	respond_to do |format|
  	 if @folder.save
  	  format.html{ redirect_to @folder, notice: 'Here is your new folder' }
  	  format.json{ render :show, status: :created, location: @folder }
  	 else
      format.html { render :new }
      format.json { render json: @folder.errors, status: :unprocessable_entity }
     end
    end
  end
 
 def update
  respond_to do |format|
  	if @folder.update
  	 format.html { redirect_to @folder, notice: 'Folder is successfully updated' }
  	 format.json { render json: :show, status: :ok, location @folder }
  	else
  	 format.html { render :new }
  	 format.json { render json: @folder.errors, status: :unprocessable_entity }
    end
   end
  end

  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Deleted a folder.' }
      format.json { head :no_content }
    end
  end
  
end




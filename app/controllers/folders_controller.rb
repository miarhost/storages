class FoldersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user! unless :admin_session
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def new
  	@folder = Folder.new
  end
  
  def index
    if admin_session
      @user = User.find(params[:user_id])
      @folders = Folder.where(user_id: @user.id)
    elsif user_session
      @user = current_user
  	  @folders = Folder.includes(:user).where(user_id: current_user.id)
        .order("created_at DESC")
    else
      redirect_to root_path, notice: 'Please login'
    end
  end

  def edit; end

  def show
    @folder = Folder.find(params[:id])
    @items = @folder.items
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
  	    format.json { render json: :show, status: :ok, location: @folder }
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
  
  private

  def folder_params
  	params.require(:folder).permit(:title, :description)
  end

  def set_folder 
    @folder = Folder.find(params[:id])
  end
  
end




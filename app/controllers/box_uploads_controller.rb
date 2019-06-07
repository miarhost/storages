class BoxUploadsController < ApplicationController     

  def new
    @box_upload = BoxUpload.new
  end

  def create 
    @box_upload = BoxUpload.new(box_upload_params)
    if box_upload.save
      @box_upload.box_file.attach(box_file)
      BoxUpload.new(@box_upload).direct_box
      render json: { message: "File uploaded" }, status: 200
    else
      file_absent
    end
  end

  def box_upload_params
    params.require(:box_upload).permit(:box_file)
  end
end
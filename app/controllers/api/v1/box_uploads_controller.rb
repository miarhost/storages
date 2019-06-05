module Api
  module V1
    class BoxUploads < Api::V1::ApplicationController

      def new
        @box_upload = BoxUpload.new
      end

      def create 
        @box_upload = BoxUpload.new(box_upload_params)
        if @box_upload.save 
          data = @box_upload.attachment
          render json: { message: "File uploaded" }, status: 200
        else
          file_absent
        end
      end

      def box_upload_params
        params.require(:box_upload).permit(:attachment)
      end
    end
  end
end

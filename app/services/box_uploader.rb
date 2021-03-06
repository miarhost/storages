class BoxUploader
  
  def initialize(box_upload)
    @box_upload = box_upload
    @adapter = Adapter::DropBox.new(@box_upload.box_path, @box_upload.box_filename)
    Rails.logger.info(@adapter)
  end

  def direct_box
    @adapter.direct_uploads
  end
end

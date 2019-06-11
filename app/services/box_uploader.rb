class BoxUploader
  
  def initialize(box_upload)
    @box_upload = box_upload
    @adapter = Adapter::DropBox.new(@box_upload.box_path)
  end

  def direct_box
    @adapter.direct_uploads
  end
end

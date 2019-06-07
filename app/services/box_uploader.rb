class BoxUploader
  
  def initialize(box_upload)
    @box_upload = box_upload
    @adapter = Adapter::DropBox.new
  end

  def direct_box
    @adapter.direct_uploads(@box_upload.box_file)
  end
end

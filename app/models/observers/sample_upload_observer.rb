class SampleUploadObserver < ActiveRecord::Observer

  def after_create(sample_upload)
    SampleFolder.create! :sample_folder.id => sample_upload.sample_folder.id
  end
  
end
require "active_storage/service/disk_service"

 module ActiveStorage
 class Service::VolumeDiskService < Service::DiskService

  def folder_for(key)
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

 end
end
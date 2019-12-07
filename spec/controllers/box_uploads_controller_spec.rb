require 'rails_helper'

RSpec.describe BoxUploadsController, type: :controller do
  
  context "when user uploads a file" do
  
    it "uploads file to DropBox" do 
      box_upload = create(:box_upload)
      allow(BoxUpload).to receive(:new).and_return(:box_file)
      allow(BoxUploader).to_receive(:box_upload)
  
      post :create, box_upload: { attribute: "value" }

      expect(BoxUploader).to_have_received(:box_upload).with(:box_file)
    end
  end
end

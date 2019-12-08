require 'rails_helper'
require "./spec/support/files_test_helpers"

RSpec.describe SampleUploadsController, type: :controller do

  describe 'POST#create' do
  	context 'with required attachment' do
      let(:singleupload) { FilesTestHelpers.png }
      subject do
        post :create, singleupload: singleupload
      end
       
      it 'returns 200' do
        expect(subject).to have_http_status(200)
      end

  	 	it 'uploads a file to a folder' do
  	    expect(subject).to change{ ActiveStorage::Attachment.count }.by(1) 
      end

      it 'creates sample upload' do
        expect(subject).to_change{ SampleUpload.count }.by(1)
        sample_upload = SampleUpload.last
        expect(sample_upload.singleupload).to be_attached
        expect(sample_upload.singleupload.filename).to eq(FilesTestHelpers.png_name)
      end
  	end
  end
end

require 'rails_helper'

RSpec.describe SampleUploadsController, type: :controller do
  let(:sample_folder) { create(:sample_folder) }
  let(:sample_upload) { create(:sample_upload) }

  describe 'POST#create' do
  	 context 'with required attachment' do

  	 	 it 'returns 200' do
  	 		  expect(response.status).to eq(200)
  	 	 end

  	 	 it 'uploads a file to a folder' do
  	 	   singleupload = fixture_file_upload(Rails.root.join('public', 'image.png'), 'image/png')
      expect {
        post :create, params: { post: { singleupload: file } }
        }.to change(ActiveStorage::Attachment, :count).by(1)
       end
  	 end
  end
end

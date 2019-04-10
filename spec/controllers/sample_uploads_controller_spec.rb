require 'rails_helper'

RSpec.describe SampleUploadsController, type: :controller do
  let(:sample_folder) { create(:sample_folder) }
  let(:sample_upload) { create :sample_upload, :with_singleupload }

  describe 'POST#create' do
  	 context 'with required attachment' do
       let(:singleupload) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'deathclaw.png'), 'image/png') }
       
       def trigger 
         post :create, params: { singleupload: singleupload } 
       end

  	 	 it 'returns 200' do
  	 		  expect(response.status).to eq(200)
  	 	 end

  	 	 it 'uploads a file to a folder' do
  	     expect { trigger }.to change(ActiveStorage::Attachment, :count).by(1)      
       end
  	 end
  end
end

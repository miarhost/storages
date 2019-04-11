require 'rails_helper'

RSpec.describe SampleUpload, type: :model do

	before do 
		 subject { Aws::S3::Resource.new(bucket: s3.bucket('storagess'), object: bucket.object) }
  end

  let(:sample_upload) { SampleUpload.new }

  describe "ActiveRecord relations" do 
    it "should have one attached attachment" do
      expect(:sample_upload).to have_one_attached(:singleupload)
    end
    it "should belong to sample folder" do 
    	 expect(:sample_upload).to belong_to(:sample_folder)
    end
  end

  describe "ActiveModel validations" do
  	 it "should validate presence of attachment" do
  	   expect(:sample_upload).to validate_presence_of(:singleupload)
  	 end
  end
 
  describe 'Attachment' do
    it 'is valid' do
      subject.image.attach(io: File.open(fixture_path + '/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      expect(sample_upload.attachment).to be_attached
    end
  end
  
  it "should upload attachment to s3" do
    expect(:sample_upload.attachment).to be_eq(subject)
  end

end



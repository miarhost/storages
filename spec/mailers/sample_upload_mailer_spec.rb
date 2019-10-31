require "rails_helper"

RSpec.describe SampleUploadMailer, type: :mailer do
  describe "#get_link" do
  	 it "delivers new sample upload link" do
  	 	 sample_upload = build(:sample_upload)
  	 	 email = double { Faker::Internet::email }
  	 	 mail = SampleUploadMailer.get_link(email)
      expect(mail).to deliver_to(email)
      expect(mail).to deliver_from("rghostme@gmail.com")
      expect(mail).to have_subject("Your upload link")
      expect(email).to have_body_text("Hello, you uploaded a file")
    end
  end
end

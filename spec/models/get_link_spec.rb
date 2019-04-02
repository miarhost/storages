require 'rails_helper'

RSpec.describe GetLink, type: :model do
  
  let(:subject) { FactoryBot.create(:get_link) }
  let(:sample_upload) { FactoryBot.create(:sample_upload, )}
  
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(255).is_at_least(10) }
  it { is_expected.to validate_uniqueness_of(:email) }

  describe "mailer" do
  	 it "has not to be working without email" do
        unique_errors = subject.errors[:email]
        expect(unique_errors.length).to eq 1
        expect(unique_errors.first).to eq "you can't send empty link"
  	 end
  end
end

require 'rails_helper'

describe GetLink do
  
  subject { FactoryBot.create(:get_link) }
  let(:sample_upload) { FactoryBot.create(:sample_upload)}

  describe 'ActiveModel Validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:email).is_at_most(255).is_at_least(10) }
  end
  
  describe "mailer" do
  	 it "has not to be working without email" do
        unique_errors = subject.errors[:email]
        expect(unique_errors.length).to eq 1
        expect(unique_errors.first).to eq "type valid email"
  	 end
  end
end

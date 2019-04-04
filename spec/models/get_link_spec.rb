require 'rails_helper'

RSpec.describe GetLink, type: :model do
  
  subject { FactoryBot.create :get_link }

  describe 'ActiveModel Validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:email).is_at_most(255).is_at_least(10) }
  end
  
  describe "email not valid" do
  	 it "formatted with regexp" do
      is_expected.to_not allow_value("emailexamplecom")
        .for(:email)
        .with_message("is invalid")
  	 end
  end
end

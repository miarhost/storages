require 'rails_helper'

RSpec.describe Item, type: :model do
  
  before(:each) do
   	subject { Item.new(attachment: "content.jpg", views: 0) }
  end

  describe "ActiveRecord relations" do
  	 it "should belong to folder" do
  	 	 expect(subject).to belong_to(:folder)
  	 end
  	 it "should have one attachment" do
  	 	 expect(subject).to have_one(:attachment)
  	 end
  end
  
end

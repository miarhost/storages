require 'rails_helper'

RSpec.describe Folder, type: :model do
  before(:each) do
   	subject { Folder.new{title: "Content", description: "user's description", user_id: 1} }
  end

  describe "ActiveRecord relations" do
  	 it "has to belong to user" do
  	 	 expect(subject).to belong_to(:user)
  	 end
  	 it "has to have many items" do
  	 	 expect(subject).to have_many(:items)
  	 end
  end

end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#show" do 
	it "shows list of folders of current_user" do
      user = double(name: "Firstname", email: "example@gmail.com")
       get :folders, attributes_for(:id, user.id)
	   expect(response).to render_template :folders
	end
  end
end

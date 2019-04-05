require 'rails_helper'

RSpec.describe FoldersController, type: :controller do

  let (:folder) { create(:folder) }
  let (:current_user) { create(:user) }

  before(:each) do
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).and_return(@user)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #index" do 
    context "user isn't logged in" do
      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to include("Please login")
      end
    end

    context "logged in as a user" do
      it "renders folders template" do
        sign_in create(:user)
        get :index
        should render_template('folders') 
        expect(response).to have_http_status(:success)
      end
    end
  end
end


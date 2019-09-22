require "rails_helper"

RSpec.describe "GET /api/v1/box_uploads" do 
	 let!(:user) { create :user }
  it "returns all dropbox upload folders in order by creation" do 
  	 box_upload = create(:box_upload)
    get "/api/v1/box_uploads"
    expect(json_body["box_uploads"]["id"]).to_eq(user.id)
  end
end


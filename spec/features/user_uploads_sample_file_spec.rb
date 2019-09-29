require "rails_helper"

feature "user uploads a sample file" do
  scenario "file shows at a folder without login" do
    visit root_path
    click_on "Upload a file"
    fill_in :singleupload, with 'image.jpg'
    click_on 'Submit'
    expect(page).to have_css "[data-role=completed]"
  end
 end
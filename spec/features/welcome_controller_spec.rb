require "rails_helper"

describe "Welcome controller" do
  it "has a landing" do
    visit '/'
    expect(page).to have_link("API Documentation")
  end

end

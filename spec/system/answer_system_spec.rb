require "rails_helper"

RSpec.describe "Answer", type: :system do
  it "renders title and body" do
    setup_and_visit_content_item("answer")

    expect(page).to have_content("Test answer")
    expect(page).to have_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
  end
end

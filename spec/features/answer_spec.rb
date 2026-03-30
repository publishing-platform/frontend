require "rails_helper"

RSpec.feature "Answer", type: :feature do
  scenario "visiting an answer page" do
    when_i_visit_an_answer_page
    then_i_see_the_page_title
    and_i_see_the_page_content
  end

private

  def when_i_visit_an_answer_page
    setup_and_visit_content_item("answer")
  end

  def then_i_see_the_page_title
    expect(page).to have_title("Test answer")
  end

  def and_i_see_the_page_content
    expect(page).to have_content("Test answer")
    expect(page).to have_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
  end
end

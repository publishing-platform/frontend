require "rails_helper"

RSpec.feature "Static Error Pages", type: :feature do
  context "when visiting 4xx page" do
    let(:error_code) { 404 }
    let(:error_text) { "Page not found" }

    scenario do
      when_i_visit_the_error_page
      then_i_see_the_error_page_title
      and_i_see_the_error_page_body
    end
  end

  context "when visiting 5xx page" do
    let(:error_code) { 500 }
    let(:error_text) { "Sorry, we’re experiencing technical difficulties" }

    scenario do
      when_i_visit_the_error_page
      then_i_see_the_error_page_title
      and_i_see_the_error_page_body
    end
  end

private

  def when_i_visit_the_error_page
    visit "/static-error-pages/#{error_code}.html"
  end

  def then_i_see_the_error_page_title
    within "head", visible: :all do
      expect(page).to have_selector("title", text: "#{error_text} - Publishing Platform", visible: :all)
    end
  end

  def and_i_see_the_error_page_body
    within "body" do
      within "main" do
        expect(page).to have_selector("h1", text: error_text)
        expect(page).to have_selector("pre", text: "Status code: #{error_code}", visible: :all)
      end
    end
  end
end

RSpec.describe "Static Error Pages", type: :system do
  context "when asked for a 4xx page" do
    it "renders the appropriate page" do
      visit "/static-error-pages/404.html"

      within "head", visible: :all do
        expect(page).to have_selector("title", text: "Page not found - Publishing Platform", visible: :all)
      end

      within "body" do
        within "main" do
          expect(page).to have_selector("h1", text: "Page not found")
          expect(page).to have_selector("pre", text: "Status code: 404", visible: :all)
        end
      end
    end
  end

  context "when asked for a 5xx page" do
    it "renders the appropriate page" do
      visit "/static-error-pages/500.html"

      within "head", visible: :all do
        expect(page).to have_selector("title", text: "Sorry, we’re experiencing technical difficulties - Publishing Platform", visible: :all)
      end

      within "body" do
        within "main" do
          expect(page).to have_selector("h1", text: "Sorry, we’re experiencing technical difficulties")
          expect(page).to have_selector("pre", text: "Status code: 500", visible: :all)
        end
      end
    end
  end
end

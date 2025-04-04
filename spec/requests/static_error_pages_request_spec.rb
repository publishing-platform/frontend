require "rails_helper"

RSpec.describe "/static-error-pages", type: :request do
  describe "GET /show" do
    context "when asked for a recognised error" do
      it "returns successfully" do
        get "/static-error-pages/404.html"

        expect(response).to have_http_status(:ok)
        expect(response.body).not_to be_empty
      end
    end

    context "when asked for an unrecognised error" do
      it "returns a 404 with no body" do
        get "/static-error-pages/555.html"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to be_empty
      end
    end
  end
end

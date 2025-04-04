require "rails_helper"

RSpec.describe "/*path", type: :request do
  let(:content_item) { PublishingPlatformSchemas::Example.find("answer", example_name: "answer") }

  it "returns sucessfully for item in content store" do
    stub_content_store_has_item(content_item["base_path"], content_item.to_json)
    get content_item["base_path"]

    expect(response).to have_http_status(:ok)
  end

  it "returns 404 for item not in content store" do
    stub_content_store_does_not_have_item(content_item["base_path"])

    get content_item["base_path"]
    expect(response).to have_http_status(:not_found)
  end

  it "returns 404 if content store falls through to special route" do
    content_item = PublishingPlatformSchemas::Example.find("special_route", example_name: "special_route")
    stub_content_store_has_item(content_item["base_path"], content_item.to_json)

    get content_item["base_path"]
    expect(response).to have_http_status(:not_found)
  end

  it "returns 410 for content items that are gone" do
    path = "/gone-item"
    stub_content_store_has_gone_item(path)

    get path
    expect(response).to have_http_status(:gone)
  end

  it "returns a redirect when content item is a redirect" do
    content_item = PublishingPlatformSchemas::Example.find("redirect", example_name: "redirect")
    stub_content_store_has_item(content_item["base_path"], content_item)

    get content_item["base_path"]
    expect(response).to redirect_to("https://www.test.publishing-platform.co.uk/test-redirected?query=answer#fragment")
  end

  it "returns 403 for forbidden item" do
    path = "/forbidden"
    stub_request(:get, %r{.*content-store.*/content#{path}}).to_return(status: 403, headers: {})

    get path
    expect(response).to have_http_status(:forbidden)
  end
end

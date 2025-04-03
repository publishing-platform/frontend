require "rails_helper"

RSpec.describe AnswerPresenter do
  let(:schema_name) { "answer" }

  it "presents the title" do
    expect(presented_item.title).to eql schema_item["title"]
  end

  it "presents the body" do
    expect(presented_item.body).to eql schema_item["details"]["body"]
  end
end
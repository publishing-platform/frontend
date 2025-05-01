# rubocop:disable Lint/DuplicateMethods
require "rails_helper"

RSpec.describe ContentItem::Withdrawable do
  let(:withdrawable) do
    Object.new.extend(described_class)
  end

  describe "#withdrawn?" do
    it "is true if withdrawn notice present" do
      class << withdrawable
        def content_item
          {
            "withdrawn_notice" => {
              "withdrawn_at" => "2016-07-12T09:47:15Z",
            },
          }
        end
      end

      expect(withdrawable.withdrawn?).to be true
    end

    it "is false if withdrawn notice not present" do
      class << withdrawable
        def content_item
          {}
        end
      end

      expect(withdrawable.withdrawn?).to be false
    end
  end

  describe "#page_title" do
    it "prepends withdrawn if content withdrawn" do
      class << withdrawable
        def title
          content_item["title"]
        end

        def content_item
          {
            "title" => "Test title",
            "withdrawn_notice" => {
              "withdrawn_at" => "2016-07-12T09:47:15Z",
            },
          }
        end
      end

      expect(withdrawable.page_title).to eql("[Withdrawn] Test title")
    end

    it "returns title if content not withdrawn" do
      class << withdrawable
        def title
          content_item["title"]
        end

        def content_item
          {
            "title" => "Test title",
          }
        end
      end

      expect(withdrawable.page_title).to eql("Test title")
    end
  end

  describe "#withdrawal_notice_component" do
    it "generates notice title and description correctly" do
      class << withdrawable
        def schema_name
          "answer"
        end

        def view_context
          ApplicationController.new.view_context
        end

        def content_item
          {
            "title" => "Test title",
            "withdrawn_notice" => {
              "explanation" => "<div><p>This content has been superseded</p></div>",
              "withdrawn_at" => "2016-07-12T09:47:15Z",
            },
          }
        end
      end

      expect(withdrawable.withdrawal_notice_component[:title]).to eql("This answer was withdrawn on <time datetime=\"2016-07-12T09:47:15Z\">12 July 2016</time>")
      expect(withdrawable.withdrawal_notice_component[:description]).to eql("<div><p>This content has been superseded</p></div>")
    end
  end
end
# rubocop:enable Lint/DuplicateMethods

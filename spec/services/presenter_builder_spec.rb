require "rails_helper"

RSpec.describe PresenterBuilder do
  let(:schema_name) { "answer" }

  let(:subject) {
    described_class.new(schema_item, "/path", ApplicationController.new.view_context).presenter
  }
  describe "#presenter" do
    it "returns correct content item presenter" do      
      expect(subject).to be_a AnswerPresenter
    end

    context "when the content item is a special route" do
      let(:schema_name) { "special_route" }

      it "raises SpecialRouteReturned error" do   
        expect { subject }.to raise_error(described_class::SpecialRouteReturned)     
      end      
    end

    context "when the content item is a redirect route" do
      let(:schema_name) { "redirect" }

      it "raises RedirectRouteReturned error" do      
        expect { subject }.to raise_error(described_class::RedirectRouteReturned) 
      end      
    end    
  end
end
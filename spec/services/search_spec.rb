require 'rails_helper'

RSpec.describe Services::Search do

  Services::Search::SCOPES.each do |scope|
    it "searches within #{scope} scope" do
      expect(scope.classify.constantize).to receive(:search).with('string')
      Services::Search.perform(query: 'string', scope: scope)
    end
  end
end
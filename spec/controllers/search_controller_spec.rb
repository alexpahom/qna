require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do

    let!(:questions) { create_list(:question, 3) }
    subject { Services::Search }

    context 'valid attributes' do

      Services::Search::SCOPES.each do |scope|
        before do
          allow(subject).to receive(:perform).and_return(questions)
          get :index, params: { query: questions.shuffle.first.title, scope: scope }
        end

        it "#{scope} returns 200" do
          expect(response).to be_successful
        end

        it "renders #{scope} index" do
          expect(response).to render_template :index
        end

        it "#{scope} assign #perform to @results" do
          expect(assigns(:results)).to eq questions
        end
      end
    end

    context 'invalid attributes' do
      it "renders index view" do
        get :index, params: { query: questions.sample.title, scope: 'invalid' }
        expect(response).to render_template :index
      end
    end
  end
end
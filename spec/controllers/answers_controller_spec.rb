require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, :answered) }
  let(:answers) { question.answers }

  describe 'GET #index' do
    before { get :index, params: { question_id: question } }

    it 'populates array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:answer) { answers.sample }

    before { get :show, params: { question_id: question, id: answer } }

    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assigns new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:answer_params) { { question_id: question, answer: attributes_for(:answer) } }
      it 'saves new answer in db' do
        # answer_params = { question_id: question, answer: attributes_for(:answer) }
        expect { post :create, params: { **answer_params } }.to change(Answer, :count).by(1)
      end

      it 'redirects to show' do
        post :create, params: { **answer_params }
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'with invalid attriburtes' do
      let(:answer_params) { { question_id: question, answer: attributes_for(:answer, :invalid) } }
      it 'does not save answer in db' do
        # answer_params = { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect { post :create, params: { **answer_params } }.to_not change(Answer, :count)
      end

      it 're-renders new' do
        post :create, params: { **answer_params }
        expect(response).to render_template :new
      end
    end
  end
end

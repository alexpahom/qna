require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, :answered) }
  let(:answers) { question.answers }

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

  describe 'GET #edit' do
    let(:answer) { answers.first }

    before do
      login(user)
      get :edit, params: { question_id: question.id, id: answer.id }
    end

    it 'assigns correct answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders proper template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    let!(:question) { create(:question, :answered) }

    context 'with valid attributes' do
      let(:answer_params) { { question_id: question, answer: attributes_for(:answer) } }

      it 'saves new answer in db' do
        expect { post :create, params: { **answer_params } }.to change(Answer, :count).by(1)
      end

      it 'redirects to show' do
        post :create, params: { question_id: question.id, **answer_params }
        expect(response).to redirect_to(questions_path(question))
      end
    end

    context 'with invalid attributes' do
      let(:answer_params) { { question_id: question, answer: attributes_for(:answer, :invalid) } }

      it 'does not save answer in db' do
        expect { post :create, params: { **answer_params } }.to_not change(Answer, :count)
      end

      it 're-renders new' do
        post :create, params: { question_id: question.id, **answer_params }
        expect(response).to render_template('questions/show')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, :answered) }

    before { login(user) }

    it 'deletes answer from db' do
      expect { delete :destroy, params: { id: question.answers.first.id } }
        .to change(Answer, :count).by(-1)
    end

    it 'redirects to question answers' do
      delete :destroy, params: { id: question.answers.first.id }
    end
  end

  describe 'PATCH #update' do
    let!(:question) { create(:question, :answered) }
    let(:answer) { question.answers.first }
    let(:answer_attributes) { { body: 'new body' } }

    before { login(user) }

    context 'with valid params' do
      before { patch :update, params: { id: answer.id, answer: answer_attributes } }

      it 'updates existing answer successfully' do
        expect(assigns(:answer)).to eq(answer)
      end

      it 'updates params successfully' do
        answer.reload
        expect(answer.body).to eq(answer_attributes[:body])
      end

      it 'redirects to answer show view' do
        expect(response).to redirect_to(assigns(:answer))
      end
    end

    context 'with invalid params' do
      let(:invalid_answer_attributes) { { body: nil } }
      let(:answer_attributes) { attributes_for(:answer) }

      before { patch :update, params: { id: answer.id, answer: invalid_answer_attributes } }

      it 'does not change answer' do
        answer.reload
        expect(answer.body).to eq(answer_attributes[:body])
      end

      it 'redirects to edit' do
        expect(response).to render_template(:edit)
      end
    end
  end
end

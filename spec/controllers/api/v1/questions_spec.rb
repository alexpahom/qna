require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" } }

  describe 'GET /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }
    let(:method) { :get }
    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { create_list(:answer, 3, question: question) }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns list of questions' do
        expect(json['questions'].size).to eq 2
      end

      it 'returns all public fields' do
        %w[id title body author_id created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      describe 'answers' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }

        it 'returns list of answers' do
          expect(question_response['answers'].size).to eq 3
        end

        it 'returns all public fields' do
          %w[id body author_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'GET /api/v1/questions/:id' do
    let(:user) { create(:user) }
    let(:question) { create(:question, :with_attachments, author: user) }
    let(:question_response) { json['question'] }
    let!(:comments) { create_list(:comment, 2, commentable: question, author: user) }
    let!(:links) { create_list(:link, 2, linkable: question) }
    let(:access_token) { create(:access_token) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
      let(:api_path) { '/api/v1/questions' }
    end

    before { get api_path, params: { access_token: access_token.token }, headers: headers }

    it_behaves_like 'Return successful'

    it_behaves_like 'Public fields' do
      let(:attrs) { %w[id title body created_at updated_at] }
      let(:resource_response) { question_response }
      let(:resource) { question }
    end

    describe 'comments' do
      it_behaves_like 'Return list' do
        let(:resource_response) { question_response['comments'] }
        let(:resource) { comments }
      end
    end

    describe 'links' do
      it_behaves_like 'Return list' do
        let(:resource_response) { question_response['links'] }
        let(:resource) { links }
      end
    end

    describe 'files' do
      it_behaves_like 'Return list' do
        let(:resource_response) { question_response['files'] }
        let(:resource) { question.files }
      end
    end
  end

  describe 'POST /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      before { get api_path, params: {access_token: access_token.token}, headers: headers }

      context 'with valid attributes' do
        it 'saves a new question in database' do
          expect { post api_path, params: { question: attributes_for(:question),
                                            access_token:access_token.token } }.to change(Question, :count).by(1)
        end

        it 'returns status :created' do
          post api_path, params: { question: attributes_for(:question), access_token: access_token.token }
          expect(response.status).to eq 201
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post api_path, params: { question: attributes_for(:question, :invalid),
                                            access_token: access_token.token } }.to_not change(Question, :count)
        end

        it 'returns unprocessible_entity' do
          post api_path, params: { question: attributes_for(:question, :invalid), access_token: access_token.token }
          expect(response.status).to eq 422
        end

        it 'returns error message' do
          post api_path, params: { question: attributes_for(:question, :invalid), access_token: access_token.token }
          expect(json['errors']).to be
        end
      end
    end
  end
end

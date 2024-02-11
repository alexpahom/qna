require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'Admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  context 'Guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  context 'Authorized user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create :question, :commented, author: user }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    context 'question' do
      it { should be_able_to :create, Question }

      it { should be_able_to :update, create(:question, author: user) }
      it { should_not be_able_to :update, create(:question, author: other) }

      it { should be_able_to :destroy, create(:question, author: user) }
      it { should_not be_able_to :destroy, create(:question, author: other) }

      it { should be_able_to :process_rank, create(:question, author: other) }
      it { should_not be_able_to :process_rank, create(:question, author: user) }
    end

    context 'answer' do
      let(:other_question) { create :question, author: other }

      it { should be_able_to :create, Answer }

      it { should be_able_to :update, create(:answer, author: user) }
      it { should_not be_able_to :update, create(:answer, author: other) }

      it { should be_able_to :destroy, create(:answer, question: question, author: user) }
      it { should_not be_able_to :destroy, create(:answer, question: question, author: other) }

      it { should be_able_to :assign_best, create(:answer, question: question, author: other) }
      it { should_not be_able_to :assign_best, create(:answer, question: other_question, author: user) }

      it { should be_able_to :process_rank, create(:answer, question: question, author: other) }
      it { should_not be_able_to :process_rank, create(:answer, question: question, author: user) }
    end

    context 'comment' do
      let(:comment) { question.comments.first }

      it { should be_able_to :create, Comment }

      it { should be_able_to :destroy, comment, author: user }
      it { should_not be_able_to :destroy, comment, author: other }
    end

    context 'Link' do
      let(:other_question) { create :question, author: other }
      it { should be_able_to :destroy, create(:link, linkable: question) }
      it { should_not be_able_to :destroy, create(:link, linkable: other_question) }
    end
  end
end

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

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, create(:question, author: user) }
    it { should_not be_able_to :update, create(:question, author: other) }

    it { should be_able_to :update, create(:answer, author: user) }
    it { should_not be_able_to :update, create(:answer, author: other) }
  end
end

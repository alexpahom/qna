require 'rails_helper'

RSpec.describe Badge, type: :model do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_one(:users_badge) }

  it 'has one attached file' do
    expect(Badge.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end

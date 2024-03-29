require 'rails_helper'

RSpec.describe UsersBadge, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:badge) }
end

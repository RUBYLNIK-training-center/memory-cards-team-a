require 'rails_helper'

RSpec.describe Import, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:user) }
  end
end

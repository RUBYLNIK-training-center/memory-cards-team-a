require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                        password_confirmation: '123456')
  end

  describe 'associations' do
    it { is_expected.to have_many(:boards) }
    it { is_expected.to have_many(:imports) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'enumerize' do
    it { should enumerize(:account_type).in(:standard, :premium) }
  end
end

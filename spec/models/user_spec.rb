require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
    password_confirmation: '123456') }

  describe 'association' do
    it { should have_many(:boards) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end

require 'rails_helper'

RSpec.describe Card, type: :model do
  subject(:card) do
    described_class.new(question: 'Anything', answer: 'Lorem ipsum')
  end

  it 'is valid with valid attributes' do
    expect(card).to be_valid
  end

  it 'is not valid without a title' do
    card.question = nil
    expect(card).not_to be_valid
  end

  it 'is not valid without a description' do
    card.answer = nil
    expect(card).not_to be_valid
  end
end

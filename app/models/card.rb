class Card < ApplicationRecord
  validates :answer, presence: true
  validates :question, presence: true
  belongs_to :board
end

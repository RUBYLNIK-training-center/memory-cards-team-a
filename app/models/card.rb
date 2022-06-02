class Card < ApplicationRecord
  validates :answer, presence: true
  validates :question, presence: true
  belongs_to :board
  enum confidence_level: %i[undefined very_bad bad medium good perfect]
end

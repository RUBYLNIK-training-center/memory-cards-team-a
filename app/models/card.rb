class Card < ApplicationRecord
  validates :answer, presence: true
  validates :question, presence: true
  belongs_to :board
  enum confidence_level: %i[undefined very_bad bad medium good perfect]

  def self.to_csv(board)
    attributes = %w[board_name card_question card_answer]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |card|
        csv << [board.name, card.question, card.answer]
      end
    end
  end
end

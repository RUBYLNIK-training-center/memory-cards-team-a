class CardImport
  def initialize(import:, user:)
    @import = import
    @user = user
  end

  def call
    @import.file.open do |tempfile|
      CSV.foreach(tempfile, headers: true) do |row|
        hash = row.to_hash
        if hash.value?(nil)
          Board.where(name: hash['board_name'].strip, user_id: @user.id).destroy_all
          return false
        end

        board = Board.find_or_create_by(name: hash['board_name'].strip, user_id: @user.id)
        board.cards.find_or_create_by(question: hash['card_question'], answer: hash['card_answer'])
      end
    end
    return true
  end
end

class AjaxController < ApplicationController
  before_action :board, :set_card
  skip_before_action :verify_authenticity_token

  def change_confidence_level
    @card.attributes = card_params
    @card.save
  end

  private

  def board
    @board = Board.find(params[:board_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = @board.cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.permit(:confidence_level, :board_id, :id)
  end
end

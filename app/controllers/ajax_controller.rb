class AjaxController < ApplicationController
  before_action :set_card
  skip_before_action :verify_authenticity_token

  def change_confidence_level
    @card.attributes = card_params
    if @card.save
      render json: @card.confidence_level, status: 200
    else
      render json: 'Error', status: 404
    end
  end

  def update_card_throw_modal
    if @card.update(card_params)
      render json: 'Good', status: 200
    else
      render json: 'Error', status: 404
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.permit(:confidence_level, :id, :question, :answer)
  end
end

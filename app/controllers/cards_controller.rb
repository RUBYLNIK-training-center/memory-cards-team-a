class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :board
  before_action :set_card, only: %i[show edit update destroy]
  before_action :correct_user
  skip_before_action :verify_authenticity_token

  def learn
    @cards = @board.cards
    if @cards.first.nil?
      redirect_to board_cards_path(@board), notice: 'First, create a card.'
    else
      render 'learn/learn'
    end
  end

  # GET /cards
  def index
    @cards = @board.cards.order(created_at: :asc)
    respond_to do |format|
      format.html
      format.csv { send_data @cards.to_csv(@board), filename: 'cards.csv' }
    end
  end

  # GET /cards/1 or /cards/1.json
  def show; end

  # GET /cards/new
  def new
    @card = @board.cards.build
  end

  # POST /cards
  def create
    @card = @board.cards.build(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to board_cards_path(@board), notice: 'Card was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to board_cards_path(@board), notice: 'Card was successfully destroyed.' }
    end
  end

  private

  def correct_user
    @cardz = current_user.boards.find_by(id: params[:board_id])
    redirect_to boards_path, notice: 'Not Authorized to See this Card' if @cardz.nil?
  end

  def board
    @board = Board.find(params[:board_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = @board.cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:question, :answer, :confidence_level)
  end
end

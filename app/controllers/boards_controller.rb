class BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[show edit update destroy]

  def index
    @boards = Board.all
  end

  def show; end

  def new
    @board = current_user.boards.build
  end

  def edit; end

  def create
    @board = current_user.boards.build(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to board_url(@board), notice: t('controller.boards.board_create') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: t('controller.boards.board_update') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: t('controller.boards.board_destroy') }
    end
  end

  private

  def correct_user
    @board = current_user.boards.find_by(id: params[:id])
    redirect_to boards_path, notice: 'Not Authorized to See this Board' if @board.nil?
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :user_id)
  end
end

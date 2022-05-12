class BoardController < ApplicationController
  before_action :authenticate_user!

  def index

    render text: 'index'
  end

  def contact

    render text: 'contact'
  end
end

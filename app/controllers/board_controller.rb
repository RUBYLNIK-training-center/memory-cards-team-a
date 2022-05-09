class BoardController < ApplicationController
  # before_action :authenticate_user!, except => [:show, :index]
  def index

    render text: 'hello'
    end
    def contact

      render text: 'hello'
    end
end

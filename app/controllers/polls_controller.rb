class PollsController < ApplicationController
  protect_from_forgery except: [:show]
  before_action :authenticate_user!, only: [:create, :new]

  after_action :allow_iframe, only: [:show]

  def index
  end

  def show
    @poll = Poll.find params[:id]
  end

  def create
    if params[:mass]
      @poll = Poll.create_with_mass_options(params, current_user.id)
    end
    render json: @poll.to_json
  end

  def new
  end


  private
  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end

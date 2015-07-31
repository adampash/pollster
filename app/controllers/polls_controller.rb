class PollsController < ApplicationController
  protect_from_forgery except: [:show]
  after_action :allow_iframe

  def index
  end

  def show
    @poll = Poll.find params[:id]
  end

  def create
    if params[:mass]
      @poll = Poll.create_with_mass_options(params)
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

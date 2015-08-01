class VotesController < ApplicationController
  def create
    cookie_id = "vote_count_#{params[:poll_id]}"
    cookies[cookie_id] = cookies[cookie_id].to_i + 1
    puts "VOTE COUNT: #{cookies[cookie_id]}"
    # allow 10 votes max via cookies
    if cookies[cookie_id].to_i > 9
      render json: {success: true}
    else
      @votes = Vote.create_all(params, request.remote_ip)
      if @votes
        render json: {success: true}
      else
        render json: {success: false}
      end
    end
  end
end

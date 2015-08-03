class VotesController < ApplicationController
  def create
    # allow 10 votes max via cookies
    if ten_votes?(params[:poll_id]) && false
      render json: {success: true}
    else
      @ballot = Ballot.create(ip_address: request.remote_ip, poll_id: params[:poll_id])
      @votes = Vote.create_all(params, @ballot)
      if @votes
        render json: {success: true}
      else
        render json: {success: false}
      end
    end
  end

  protected
  def ten_votes?(poll_id)
    cookie_id = "vote_count_#{poll_id}"
    cookies[cookie_id] = cookies[cookie_id].to_i + 1
    puts "VOTE COUNT: #{cookies[cookie_id]}"
    cookies[cookie_id].to_i > 9
  end
end

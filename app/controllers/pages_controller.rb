class PagesController < ApplicationController
  def hello
  end

  def home
  end

  def json
    render json: {name: 'person'}
  end
end

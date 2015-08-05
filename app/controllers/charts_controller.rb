class ChartsController < ApplicationController
  layout "charts"
  before_action :authenticate_user!

  def votes

  end
end

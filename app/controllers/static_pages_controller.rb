class StaticPagesController < ApplicationController
  def index
  @proprietor= current_user.proprietor
  end

end

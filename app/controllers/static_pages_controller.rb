# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      @proprietor = current_user.proprietor
      @homes = @proprietor.homes
    end
  end
end

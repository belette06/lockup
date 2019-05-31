# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    if @proprietor.nil?
      @proprietor = current_user.proprietor
      @homes = @proprietor.homes
    end
  end
end

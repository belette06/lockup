# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    if current_user.present?
      if @proprietor.nil? || @proprietor.empty?
        @proprietor = current_user.proprietor
        #if  !@homes.nil? || !@homes.empty?
        #end


      end
    end
  end
end

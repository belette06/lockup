    # frozen_string_literal: true
require 'pry'
class ProprietorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proprietor, only: %i[show edit update destroy]

def show
  @homes = @proprietor.homes
  @openning = Appointment.openings
  @appointement = Appointment.appointments

end

  def new
    @proprietor = Proprietor.new
  end

  def create
    @proprietor = Proprietor.new(params_proprietor)
    @proprietor.user = current_user
    if @proprietor.save
      redirect_to root_path, notice: 'Proprietor was successfully create.'
    else
      render :new
    end
  end

  def edit;  end

  def update
    if @proprietor.update(params_proprietor)
      redirect_to @proprietor, notice: 'Proprietor was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_proprietor
    if @proprietor.delete
      redirect_to @proprietor, notice: 'Proprietor was successfully destroy.'
    else
      render :edit
    end
  end

  private

  def params_proprietor
    params.require(:proprietor).permit(:name, :user)
  end

  def set_proprietor
    @user = current_user
    @proprietor = @user.proprietor
  end
end

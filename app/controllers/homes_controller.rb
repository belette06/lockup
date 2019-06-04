# frozen_string_literal: true
require "pry"
class HomesController < ApplicationController
  before_action :set_homes, only: %i[show update edit destroy]

  def index
    @proprietor = current_user.proprietor
    @homes = @proprietor.homes.all
  end

  def show; end

  def new
    @home = Home.new
    @appointment = @home.appointments.build
  end

  def create
    @proprietor = current_user.proprietor
    @home = @proprietor.homes.build(params_homes)
    @appointment = Appointment.new(params_appointment)
    do_something_with_params
      if @home.save
      redirect_to @home, notice: 'Home create'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @home.update(params_homes)
      redirect_to @home, notice: 'updated..'
    else
      render :edit
    end
  end

  def destroy
    @home.destroy
      redirect_to @home, notice: 'destroy..'
  end

  def do_something_with_params
    params.to_unsafe_h.slice(:params_homes, :params_appointment)
  end

  def params_homes
    params.require(:home).permit(:name, :proprietor)
  end

def params_appointment
  params.require(:appointment).permit(:kind, :starts_at, :ends_at, :weekly_recurring)
end
  def set_homes
    @home = Home.find(params[:id])
  end
end

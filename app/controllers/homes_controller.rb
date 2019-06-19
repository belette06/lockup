# frozen_string_literal: true
require "pry"
class HomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_homes, only: %i[show update edit destroy]
  before_action :set_proprietor, only: %i[index new create]

  def index
    @homes = @proprietor.homes.all
  end

  def show; end

  def new
    @home= @proprietor.homes.build
    @home.build_appointment
  end

  def create
    @home = @proprietor.homes.build
    @home.appointment= @home.build_appointment
    @home.name = params[:home][:name]
    @home.appointment.kind = params[:home][:appointment][:kind]
    @home.appointment.starts_at = params[:home][:appointment][:starts_at]
    @home.appointment.ends_at = params[:home][:appointment][:ends_at]
    @home.appointment.weekly_recurring= params[:home][:appointment][:weekly_recurring]

   if  @home.save
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

  private

  def params_homes
  params.require(:home).permit(:name, :proprietor, appointment:[:kind , :starts_at , :ends_at, :weekly_recurring])
  end


  def params_appointment
    params.require(:appointment).permit(:kind , :starts_at , :ends_at, :weekly_recurring)

  end

  def params_home
    params.require(:home).permit(:name, :proprietor)

  end

  def set_homes
    @home = Home.find(params[:id])
  end

  def set_proprietor
    @proprietor = current_user.proprietor
  end
end

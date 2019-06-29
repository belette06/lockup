# frozen_string_literal: true
require "pry"
class Proprietors::HomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_homes, only: %i[show update edit destroy]
  before_action :set_proprietor, only: %i[new create index new create]

  def index
    @homes = @proprietor.homes.all
  end

  def show; end

  def new
    @home = @proprietor.homes.new
    @home.appointment= @home.build_appointment
  end

  def create
    @home = @proprietor.homes.build
    @home.appointment = @home.build_appointment
    @home.name = params[:home][:name]
    @home.appointment.kind = params[:home][:appointment][:kind]
    @home.appointment.starts_at = params[:home][:appointment][:starts_at]
    @home.appointment.ends_at = params[:home][:appointment][:ends_at]
    @home.appointment.weekly_recurring = params[:home][:appointment][:weekly_recurring]

    @home.appointment.home_id = params[:home][:appointment][:home_id]
   if  @home.save
     redirect_to proprietors_home_path(@proprietor, @home), notice: 'Home create'
    else
      render :new
    end
  end


  def edit; end

  def update
    @home.name = params[:homes][:name]
    @home.appointment.kind = params[:homes][:appointment][:kind]
    @home.appointment.starts_at = params[:homes][:appointment][:starts_at]
    @home.appointment.ends_at = params[:homes][:appointment][:ends_at]
    @home.appointment.weekly_recurring= params[:homes][:appointment][:weekly_recurring]
    if @home.update(params_homes)
      redirect_to proprietors_home_path(@proprietor, @home), notice: 'updated..'
    else
      render :edit
    end
  end

  def destroy
    @home.destroy
      redirect_to proprietor_home_path(@proprietor, @home), notice: 'destroy..'
  end

  private

  def params_home
    params.require(:homes).permit(:name, :proprietor)

  end

  def set_homes
    @home = Home.find(params[:id])
  end

  def set_proprietor
    @proprietor = current_user.proprietor
  end
end


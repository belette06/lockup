# frozen_string_literal: true
require "pry"
class Proprietors::HomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proprietor

  def index
    @homes = @proprietor.homes.all
  end

  def show
    @home = Home.find(params[:id]) || Home.find(params[:home_id])
  end

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
   if  @home.save
     @home.appointment.home_id = @home.id
     @home.appointment.save
     redirect_to proprietors_home_path(@proprietor), notice: 'Home create'
    else
      render :new
    end
  end

  def edit
    @home = Home.find(params[:id]) || Home.find(params[:home_id])
  end

  def update
    @home = Home.find(params[:id]) || Home.find(params[:home_id])
    @home.name = params_home[:name]
    @home.save if @home.name_changed?
    if @home.appointment.update(params_home[:appointment])
     redirect_to proprietors_home_path(@proprietor, @home), notice: 'updated..'
    else
      render :edit
    end
  end

  def destroy
    @home = Home.find(params[:id]) || Home.find(params[:home_id])
    @home.destroy
      redirect_to proprietors_homes_path(@proprietor), notice: 'destroy..'
  end

  private

  def params_home
    params.require(:home).permit(params.keys, :name, appointment: ([:kind, :starts_at, :ends_at, :weekly_recurring])).to_h
  end

  def set_proprietor
    @proprietor = current_user.proprietor
  end
end


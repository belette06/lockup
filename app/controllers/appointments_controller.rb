# frozen_string_literal: true

require 'pry'
class AppointmentsController < ApplicationController
  before_action :set_home, only: %i[new create edit update destroy index]

  def index
    @appointments = @home.appointments.all

    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @appointment }
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
    @tenant = Tenant.new
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = Appointment.new
    @tenant = Tenant.new(tenant_params)
    #@appointment.kind = "appointments"
    @appointment.home_id = @home.id
    if @tenant.save
      @appointment.tenant_id = @tenant.id
    end

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to [@home, @appointment], notice: 'Product was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
      else
        format.html { render action: "new" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update(params[:tenant])
        format.html { redirect_to @appointment, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointment_url }
      format.json { head :no_content }
    end
  end

  private

  def set_home
    @home = Home.find(params[:home_id])
  end

  def tenant_params
    params.require(:tenant).permit(:name)
  end
end

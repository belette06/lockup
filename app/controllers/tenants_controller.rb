# frozen_string_literal: true

require 'pry'
class TenantsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_tenant, only: %i[show edit update destroy]
  before_action :set_home, only: %i[show edit new update destroy]

  def index
    @tenants = []
    #  @tenants = current_user.tenants if current_user
  end

  def show
    @appointment = @tenant.appointments
  end

  def new
    @appointment = Appointment.new
    @tenant = Tenant.new
    @appointment.tenant = @home.tenants
  end

  def create
    @appointment = @home.appointment.build(params[:appointment])
    @tenant = Tenant.new(params[:tenant])


    if @tenant.valid?
      @tenant = @appointments.tenant
      if @tenant.name.any?
        @tenant.save
        redirect_to tenants_path
      end
      @appointment.save
    else
      render :new
    end
  end

  def edit; end

  def update
    @tenant.update(tenant_params)
    redirect_to tenant_path(@tenant)
  end

  def destroy
    @tenant.destroy
    redirect_to tenants_path
  end

  private

  def set_tenant
    @tenant = Tenants.find_by(id: params[:id])
    if @tenants.nil?
      flash[:error] = "Client not found."
      redirect_to tenants_path
    end
  end

  def set_home
    @home = Home.find(params[:home_id])
  end

  def client_params
    params.require(:tenant).permit(:name)
  end
end
